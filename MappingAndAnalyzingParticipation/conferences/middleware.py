from django.http import HttpResponse


class KumuCorsMiddleware:
    """Add CORS headers to /api/kumu/ endpoints so Kumu.io can fetch them."""

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        if request.path.startswith('/api/kumu/'):
            if request.method == 'OPTIONS':
                response = HttpResponse(status=204)
                response['Access-Control-Allow-Origin'] = '*'
                response['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
                response['Access-Control-Allow-Headers'] = 'Content-Type, Accept'
                response['Access-Control-Max-Age'] = '86400'
                return response
            response = self.get_response(request)
            response['Access-Control-Allow-Origin'] = '*'
            response['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
            return response
        return self.get_response(request)
