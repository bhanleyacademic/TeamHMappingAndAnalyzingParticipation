from django.shortcuts import render


def home(request):
    return render(request, 'marketing/index.html')


def about(request):
    return render(request, 'marketing/about.html')


def services(request):
    return render(request, 'marketing/services.html')


def pricing(request):
    return render(request, 'marketing/pricing.html')


def contact(request):
    return render(request, 'marketing/contact.html')


def faq(request):
    return render(request, 'marketing/faq.html')


def spa_shell(request, path=''):
    """Serves the Vite-built index.html for all /app/* routes. Auth is handled by Vue/JWT."""
    from django.conf import settings
    from django.http import FileResponse
    index_path = settings.STATICFILES_DIRS[0] / 'rasket' / 'index.html'
    return FileResponse(open(index_path, 'rb'), content_type='text/html')
