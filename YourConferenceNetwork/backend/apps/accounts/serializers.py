from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from .models import UserProfile

User = get_user_model()


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['organization', 'job_title', 'phone', 'timezone', 'onboarding_complete', 'avatar']


class UserSerializer(serializers.ModelSerializer):
    profile = UserProfileSerializer(read_only=True)

    class Meta:
        model = User
        fields = ['id', 'email', 'first_name', 'last_name', 'username', 'role', 'profile', 'date_joined']
        read_only_fields = ['id', 'email', 'role', 'date_joined']


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, min_length=8)
    password2 = serializers.CharField(write_only=True, label='Confirm password')

    class Meta:
        model = User
        fields = ['email', 'first_name', 'last_name', 'password', 'password2']

    def validate(self, data):
        if data['password'] != data['password2']:
            raise serializers.ValidationError({'password2': 'Passwords do not match.'})
        return data

    def create(self, validated_data):
        validated_data.pop('password2')
        return User.objects.create_user(**validated_data)


class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    """Augment the standard JWT payload with user role and profile fields."""

    def validate(self, attrs):
        data = super().validate(attrs)
        user = self.user
        # Embed user info so the Vue SPA can read it from the token payload
        data['user'] = {
            'id': user.id,
            'email': user.email,
            'firstName': user.first_name,
            'lastName': user.last_name,
            'username': user.username or user.email,
            'role': user.role,
        }
        return data

    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        token['role'] = user.role
        token['email'] = user.email
        return token


class UpdateProfileSerializer(serializers.ModelSerializer):
    organization = serializers.CharField(source='profile.organization', required=False, allow_blank=True)
    job_title = serializers.CharField(source='profile.job_title', required=False, allow_blank=True)
    phone = serializers.CharField(source='profile.phone', required=False, allow_blank=True)
    timezone = serializers.CharField(source='profile.timezone', required=False)

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'username', 'organization', 'job_title', 'phone', 'timezone']

    def update(self, instance, validated_data):
        profile_data = validated_data.pop('profile', {})
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()
        profile = instance.profile
        for attr, value in profile_data.items():
            setattr(profile, attr, value)
        profile.save()
        return instance


class PasswordResetRequestSerializer(serializers.Serializer):
    email = serializers.EmailField()


class PasswordResetConfirmSerializer(serializers.Serializer):
    uid = serializers.CharField()
    token = serializers.CharField()
    new_password = serializers.CharField(min_length=8)
