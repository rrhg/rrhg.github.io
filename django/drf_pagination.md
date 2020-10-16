1. Whats the basic idea of pagination in DRF ?
1. Whats included in the json response ?
1. Where else it can be included ?
1. Is it posible that pagination would give performance problems ?
1. How & why ?    
   
--------------------

1. That the json response includes :
   1. a url to get the previous page(items)
   1. a url to get the next page(items)
1. The pagination API can support either:
   1. Pagination links that are provided as part of the content of the response.
   1. Pagination links that are included in response headers, such as Content-Rang    e or Link.
1. Still need to research about performance, but :
   1. It probably depends on how DRF is constructing de queries. The approaches are :
      1. the problematic OFFSET approach, in which an integer value is used to keep track of pages
      1. an advanced form known as "keyset" or "seek" pagination, in which one builds a query for the desired page of results by referring to the last record of the previous page.”
      1. More on this in the book "The Temple of Django Database Performance"
1. I think ? if can keep pages to 100 or more items, maybe won't need to pay to much attention to this.
