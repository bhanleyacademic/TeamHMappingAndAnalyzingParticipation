from django.db import migrations, models


def seed_site_settings(apps, schema_editor):
    SiteSettings = apps.get_model('api', 'SiteSettings')
    SiteSettings.objects.get_or_create(pk=1, defaults={'free_tier_override': False})


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name='SiteSettings',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('free_tier_override', models.BooleanField(
                    default=False,
                    help_text='When True, all authenticated users pass IsSubscribed checks. Use during beta / before Stripe is live.',
                )),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'verbose_name': 'Site Settings',
            },
        ),
        migrations.RunPython(seed_site_settings, migrations.RunPython.noop),
    ]
