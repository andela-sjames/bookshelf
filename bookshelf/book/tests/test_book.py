from django.test import TestCase, Client
from django.urls import reverse

from book.models import Book, Category
from book.views import HomeView

class BookShelfTestCase(TestCase):
    
    def setUp(self):
        self.client = Client()
        self.category = Category.objects.create(name='Sports')
        self.book = Book.objects.create(
            title='Downtown Man', 
            author='James Bond', 
            category=self.category)

class TestModelCreation(BookShelfTestCase):
    pass


class TestRoutesViews(BookShelfTestCase):
    
    def test_homepage(self):
        reponse = self.client.get(reverse('homepage'))
        self.assertEqual(response.status_code, 200)

    def test_search_books_works(self):

        query_result = HomeView.search_book('Downtown')
        book = [book for book in query_result]
        self.assertEqual(book[0].title,'Downtown Man')



    
    
