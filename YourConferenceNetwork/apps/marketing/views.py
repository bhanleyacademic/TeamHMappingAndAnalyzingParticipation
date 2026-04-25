from django.conf import settings
from django.contrib import messages
from django.core.mail import send_mail
from django.shortcuts import render, redirect
from django.views.generic import TemplateView

from .forms import ContactForm, WaitlistForm
from .models import WaitlistEntry


class HomeView(TemplateView):
    template_name = 'marketing/index.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['waitlist_form'] = WaitlistForm()
        return ctx


class PricingView(TemplateView):
    template_name = 'marketing/pricing.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['waitlist_form'] = WaitlistForm()
        return ctx


class HowItWorksView(TemplateView):
    template_name = 'marketing/how-it-works.html'


class AboutView(TemplateView):
    template_name = 'marketing/about.html'


class FaqView(TemplateView):
    template_name = 'marketing/faq.html'


def contact(request):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            try:
                send_mail(
                    subject=f"[yourconference.network] Contact from {form.cleaned_data['name']}",
                    message=(
                        f"Name: {form.cleaned_data['name']}\n"
                        f"Email: {form.cleaned_data['email']}\n\n"
                        f"{form.cleaned_data['message']}"
                    ),
                    from_email=settings.DEFAULT_FROM_EMAIL,
                    recipient_list=[settings.CONTACT_EMAIL],
                    fail_silently=True,
                )
            except Exception:
                pass
            messages.success(request, "Thanks! We'll be in touch shortly.")
            return redirect('marketing:contact')
    else:
        form = ContactForm()
    return render(request, 'marketing/contact.html', {'form': form})


def waitlist_signup(request):
    if request.method == 'POST':
        form = WaitlistForm(request.POST)
        if form.is_valid():
            entry, created = WaitlistEntry.objects.get_or_create(
                email=form.cleaned_data['email'],
                defaults={'org_name': form.cleaned_data.get('org_name', '')},
            )
            if created:
                try:
                    send_mail(
                        subject="You're on the yourconference.network waitlist!",
                        message=(
                            "Thanks for your interest in yourconference.network cloud hosting.\n\n"
                            "We'll notify you as soon as cloud hosting is available.\n\n"
                            "In the meantime, you can self-host for free:\n"
                            "https://github.com/your-org/yourconference.network\n\n"
                            "— The yourconference.network team"
                        ),
                        from_email=settings.DEFAULT_FROM_EMAIL,
                        recipient_list=[entry.email],
                        fail_silently=True,
                    )
                    send_mail(
                        subject=f"[waitlist] New signup: {entry.email}",
                        message=f"Email: {entry.email}\nOrg: {entry.org_name or '(none)'}",
                        from_email=settings.DEFAULT_FROM_EMAIL,
                        recipient_list=[settings.CONTACT_EMAIL],
                        fail_silently=True,
                    )
                except Exception:
                    pass
                messages.success(request, "You're on the list! We'll be in touch when cloud hosting launches.")
            else:
                messages.info(request, "You're already on the waitlist — we'll be in touch soon!")
        else:
            messages.error(request, "Please enter a valid email address.")

    # Always redirect back to wherever they came from
    next_url = request.POST.get('next') or request.META.get('HTTP_REFERER') or '/'
    return redirect(next_url)
