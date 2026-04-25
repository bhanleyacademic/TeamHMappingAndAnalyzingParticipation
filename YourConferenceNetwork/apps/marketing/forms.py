from django import forms
from .models import WaitlistEntry


class WaitlistForm(forms.ModelForm):
    class Meta:
        model = WaitlistEntry
        fields = ['email', 'org_name']
        widgets = {
            'email': forms.EmailInput(attrs={
                'placeholder': 'you@yourorg.org',
                'class': 'form-control',
            }),
            'org_name': forms.TextInput(attrs={
                'placeholder': 'Organization name (optional)',
                'class': 'form-control',
            }),
        }


class ContactForm(forms.Form):
    name = forms.CharField(
        max_length=200,
        widget=forms.TextInput(attrs={'placeholder': 'Your name', 'class': 'form-control'}),
    )
    email = forms.EmailField(
        widget=forms.EmailInput(attrs={'placeholder': 'you@yourorg.org', 'class': 'form-control'}),
    )
    message = forms.CharField(
        widget=forms.Textarea(attrs={
            'placeholder': 'Tell us about your organization and what you want to analyze...',
            'rows': 5,
            'class': 'form-control',
        }),
    )
