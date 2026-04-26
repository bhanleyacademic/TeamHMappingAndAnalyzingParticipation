from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('analysis', '0004_dataset_category_map'),
    ]

    operations = [
        migrations.AddField(
            model_name='attendance',
            name='website',
            field=models.URLField(blank=True),
        ),
    ]
