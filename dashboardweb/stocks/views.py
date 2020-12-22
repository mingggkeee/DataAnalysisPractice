from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.generic import TemplateView, View

from django.core import serializers

from .models import StockMaster

# Create your views here.

class HomeView(TemplateView):
    template_name = 'stocks/home.html'

class MarketInfoView(View):
    def get(self, request): # view에서 상속 받은 메서드 -> 재정의, 브라우저에서 get 요청을 보내면 호출되는 메서드
        # return HttpResponse("Hello, there", content_type='text/plain;charset=utf-8')   # HTML을 응답하는 객체 반환
        import FinanceDataReader as fdr
        kospi = fdr.DataReader("KS11", '20201221')
        close_value1 = str(kospi.values[0][0])

        kosdaq = fdr.DataReader("KQ11", '20201221')
        close_value2 = str(kosdaq.values[0][0])

        dowjones = fdr.DataReader("DJI", '20201221')
        close_value3 = str(dowjones.values[0][0])

        nasdaq = fdr.DataReader("IXIC", '20201221')
        close_value4 = str(nasdaq.values[0][0])

        return HttpResponse("{0},{1},{2},{3}".format(close_value1, close_value2, close_value3, close_value4), content_type='text/plain;charset=utf-8')   # HTML을 응답하는 객체 반환

class SearchView(View):

    def get(self, request, key):
        searched_stocks = StockMaster.objects.filter(name__contains=key)  # name like %key%
        serialized_stocks = serializers.serialize('json', searched_stocks)  # serialize : instance -> json string
        return JsonResponse(serialized_stocks, safe=False, json_dumps_params={'ensure_ascii':False})

class StocksDetailView(View):
    def get(self, request, pk):

        import FinanceDataReader as fdr
        import json

        # stock = StockMaster.objects.get(symbol=pk)
        stocks = StockMaster.objects.filter(symbol=pk)
        stocks = list(stocks.values())  # django의 모델 인스턴스 컬렉션을 일반 리스트로 변경
        # print(stocks)
        for stock in stocks:
            stock_info = fdr.DataReader(pk, '20200701').fillna('').reset_index()
            stock_info["Date"] = stock_info['Date'].astype('string')
            stock['stats'] = stock_info.values.tolist()
        serialized_stocks = json.dumps(stocks, ensure_ascii=False)
        return HttpResponse(serialized_stocks, content_type="application/json")
