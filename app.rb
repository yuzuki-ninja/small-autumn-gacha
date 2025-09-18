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
  { image: 'acorn.png', text: 'どんぐりを見つけた！' },
  { image: 'persimmon.png', text: '柿を見つけた！' },
  { image: 'cosmos.png', text: 'コスモスを見つけた！' },
  { image: 'chestnut.png', text: '栗を見つけた！' }
]

get '/' do
  "Hello, Small Autumn Gacha! アプリが起動しました🍂"
end

get '/loading' do
  "Loading page - 秋を探しています..."
end

get '/result' do
  result = AUTUMN_RESULTS.sample
  "結果: #{result[:text]}"
end