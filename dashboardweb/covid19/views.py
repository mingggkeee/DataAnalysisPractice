from django.shortcuts import render
from django.views.generic import TemplateView, View
from django.http import HttpResponse, JsonResponse

# Create your views here.

class HomeView(TemplateView):
    template_name = 'covid19/home.html'

class ConfirmedStatView(View):
    def get(self, request):

        import requests
        import xmltodict
        import json

        url = 'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson'
        api_key = '4tXhLMDn4%2BurQf1HK5WUt0Y5duMWehSLngk1lzHV4hErl8hrKNCopi6tBU5G8w8O2At3vYb%2Fi2u9h%2BrOq9WQJA%3D%3D'
        # http://localhost:8000/a/b/c?name=x&age=30
        qs = 'ServiceKey={0}&pageNo={1}&numOfRows={2}&startCreateDt={3}&endCreateDt{4}'.format(api_key, 1, 10, '20201222', '20201222')

        response = requests.get(url + '?' + qs)

        response_dict = xmltodict.parse(response.content)   # xml -> orderddict
        response_json = json.dumps(response_dict, ensure_ascii=False)   # oredreddict -> json-string
        response_dict2 = json.loads(response_json) # json-string -> general dict
        item_list = response_dict2['response']['body']['items']['item']
        item_list_json = json.dumps(item_list, ensure_ascii=False)

        return HttpResponse(item_list_json, content_type='application/json;charset=utf-8')

