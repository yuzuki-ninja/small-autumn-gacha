require 'sinatra'
require 'sinatra/reloader' if development?

# 静的ファイルの設定
set :public_folder, 'public'
set :views, 'views'

# すべてのIPからのアクセスを許可（Docker環境で必要）
set :bind, '0.0.0.0'
set :port, 4567

# 秋の結果データ
AUTUMN_RESULTS = [
  { image: 'momiji.png', text: 'もみじを見つけた！' },
  { image: 'sakura.png', text: '残念・・・季節外れ・桜を見つけた！' },
  { image: 'icho.png', text: 'イチョウを見つけた！' },
  { image: 'higanbana.png', text: '彼岸花を見つけた！' },
  { image: 'kuri.png', text: '栗を見つけた！' }
]

get '/' do
  erb :index
end

get '/loading' do
  erb :loading
end

get '/result' do
  @selected_item = weighted_random_select(AUTUMN_ITEMS)
  erb :result
end

private

