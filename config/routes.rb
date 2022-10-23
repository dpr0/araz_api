# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  resources :users
  resources :inn,     only: :show
  resources :debtors, only: :show
  resources :fsin,    only: :show
  resources :nalog,   only: :show
  post '/fedresurs', to: 'fedresurs#show'
end

# curl 'https://service.nalog.ru/inn-new-proc.do' \
#   -H 'Cookie: _ym_uid=1634105627353283064; _ym_d=1658730889; JSESSIONID=78E7C5174965F76DE40A10C0565F3591; uniI18nLang=RUS; _ym_isad=1; _ym_visorc=b; upd_inn=24F29968FD73E6788483CACCDA928DEC3B6EE73E26F7C18FA80B66B4BC10C748' \
#   -H 'X-Requested-With: XMLHttpRequest' \
#   --data-raw 'c=find&captcha=&captchaToken=&fam=%D0%92%D0%B8%D1%82%D0%B2%D0%B8%D1%86%D0%BA%D0%B8%D0%B9&nam=%D0%94%D0%BC%D0%B8%D1%82%D1%80%D0%B8%D0%B9&opt_otch=1&bdate=26.08.1983&doctype=21&docno=49+07+851823&docdt=18.03.2008'
#
# curl 'https://kad.arbitr.ru/Kad/SearchInstances' \
#   -H 'content-type: application/json' \
#   -H 'cookie: pr_fp=93507f585f80bf8f7b97ed641610e3e1373fc3a0a9c6b51abdea108294991545; wasm=677c72aa4ef1e80f9b08abb0f305f201' \
#   -d '{"Page":1,"Count":25,"Courts":[],"DateFrom":null,"DateTo":null,"Sides":[{"Name":"530470122955","Type":-1,"ExactMatch":false}],"Judges":[],"CaseNumbers":[],"WithVKSInstances":false}'
