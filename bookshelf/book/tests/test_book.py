from django.test import TestCase, Client
from django.urls import reverse

from book.models import Book, Category
from book.views import HomeView

class BookShelfTestCase(TestCase):
    
    def setUp(self):
        self.client = Client()
        self.category = Category.objects.create(name='Sports')
        self.category2 = Category.objects.create(name='Music')
        self.book = Book.objects.create(
            title='Downtown Man', 
            author='James Bond', 
            category=self.category)

        self.book = Book.objects.create(
            title='Classic Man', 
            author='Jackson 5', 
            category=self.category2)
        

class TestModelCreation(BookShelfTestCase):
    pass


class TestRoutesViews(BookShelfTestCase):
    
    def test_homepage(self):
        response = self.client.get(reverse('homepage'))
        self.assertEqual(response.status_code, 200)

    def test_search_books_works(self):
        query_result = HomeView.search_book('Downtown')
        book = [book for book in query_result]
        self.assertEqual(book[0].title,'Downtown Man')

    def test_searh_category(self):
        query_result = HomeView.search_book('sports')
        book = [book for book in query_result]
        self.assertEqual(book[0].category.name, 'Sports')

    def test_seach_book_name_category(self):
        query_result = HomeView.search_book('Downtown Music')
        book = [book for book in query_result]
        self.assertEqual([], book)

    def test_mismatch_book_name(self):
        query_result = HomeView.search_book('Downtown Sports')
        book = [book for book in query_result]
        self.assertEqual(len(book), 0)
        


    
    
