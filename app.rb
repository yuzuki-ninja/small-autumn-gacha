require 'sinatra'

if development?
  require 'sinatra/reloader'
end

# 静的ファイルの設定
set :public_folder, 'public'
set :views, 'views'

# 開発環境での設定（Docker用）
configure :development do
  set :bind, '0.0.0.0'  # Dockerコンテナからアクセス可能にする
  set :port, 4567
end

# 本番環境での設定
configure :production do
  set :port, ENV['PORT'] || 4567
  set :bind, '0.0.0.0'  # Renderなどのクラウドサービスで必要
end

# 秋の結果データ
AUTUMN_ITEMS = [
  { image: 'momiji.png', text: '✨もみじを見つけた✨', weight: 20 },
  { image: 'icho.png', text: '✨イチョウを見つけた✨', weight: 20 },
  { image: 'higanbana.png', text: '✨彼岸花を見つけた✨', weight: 15 },
  { image: 'kuri.png', text: '✨栗を見つけた✨', weight: 15 },
  { image: 'yakiimo.png', text: '✨焼き芋を見つけた✨', weight: 15 },
  { image: 'halloween_pumpkin.png', text: '🎃かぼちゃのランタンを見つけた🎃', weight: 10 },
  { image: 'sakura.png', text: '😮季節外れ！桜を見つけた😮', weight: 5 },
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

  # 重み付きランダム選択メソッド
  def weighted_random_select(items)
    total_weight = items.sum { |item| item[:weight] }
    random_number = rand(1..total_weight)
  
    current_weight = 0
    items.each do |item|
    current_weight += item[:weight]
    return item if random_number <= current_weight
  end
  
  # フォールバック（通常は到達しない）
  items.first
end