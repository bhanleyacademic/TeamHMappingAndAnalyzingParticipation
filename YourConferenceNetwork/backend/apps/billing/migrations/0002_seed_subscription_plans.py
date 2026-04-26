from django.db import migrations


def seed_plans(apps, schema_editor):
    SubscriptionPlan = apps.get_model('billing', 'SubscriptionPlan')
    plans = [
        dict(
            name='Free',
            stripe_price_id='',
            max_datasets=1,
            max_records_per_dataset=10000,
            can_export_kumu=False,
            can_export_csv=False,
            can_view_network_maps=False,
            price_monthly='0.00',
            display_order=0,
            is_active=True,
        ),
        dict(
            name='Starter',
            stripe_price_id='',  # fill in when Stripe is configured
            max_datasets=5,
            max_records_per_dataset=50000,
            can_export_kumu=True,
            can_export_csv=True,
            can_view_network_maps=True,
            price_monthly='49.00',
            display_order=1,
            is_active=True,
        ),
        dict(
            name='Pro',
            stripe_price_id='',
            max_datasets=-1,
            max_records_per_dataset=-1,
            can_export_kumu=True,
            can_export_csv=True,
            can_view_network_maps=True,
            price_monthly='149.00',
            display_order=2,
            is_active=True,
        ),
    ]
    for plan in plans:
        SubscriptionPlan.objects.get_or_create(name=plan['name'], defaults=plan)


class Migration(migrations.Migration):

    dependencies = [
        ('billing', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(seed_plans, migrations.RunPython.noop),
    ]
