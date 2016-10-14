from django.shortcuts import render
from django.views.generic import TemplateView
from django.db.models import Q

from book.models import Book, Category

# Create your views here.
class HomeView(TemplateView):
    template_name = 'book.html'

    def get(self, request):
        
        query_text = request.GET.get('q', '')
        arg = dict()
        all_category = Category.objects.all()

        if query_text:
            books = self.search_book(query_text)
            arg['books'] = books
            arg['categories'] = all_category
        
        if not query_text:
            all_books = Book.objects.all()
            arg['books'] = all_books
            arg['categories'] = all_category
        
        return render(request, self.template_name, arg)

    @staticmethod
    def search_book(query_text):

        try:
            search_result = Book.objects.filter(
                Q(title__icontains=query_text) | Q(category__name__icontains=query_text)
            )
        except Book.DoesNotExist:
            search_result = []

        return search_result

        
        