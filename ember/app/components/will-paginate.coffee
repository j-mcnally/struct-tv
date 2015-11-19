WillPaginate = Ember.Component.extend
  pageCount: 0
  curPage: 1
  pages: (->
    pages = []
    for i in [1..@get('pageCount')]
      pages.push({num: i, current: (@get('curPage') == "#{i}")})
    pages
  ).property('pageCount', 'curPage')
  hasPages: (->
    @get('pageCount') > 0
  ).property('pageCount')
  canMoveBack: (->
    parseInt(@get('curPage')) > 1
  ).property('curPage')
  canMoveForward: (->
    parseInt(@get('curPage')) < @get('pageCount')
  ).property('curPage', 'pageCount')
  nextPage: (->
    parseInt(@get('curPage')) + 1
  ).property('curPage')
  prevPage: (->
    parseInt(@get('curPage')) - 1
  ).property('curPage')


`export default WillPaginate`