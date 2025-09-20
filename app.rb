require 'sinatra'
require 'sinatra/reloader' if development?

# 静的ファイルの設定
set :public_folder, 'public'
set :views, 'views'

# すべてのIPからのアクセスを許可（Docker環境で必要）
set :bind, '0.0.0.0'
set :port, 4567

# 秋の結果データ
AUTUMN_ITEMS = [
  { image: 'momiji.png', text: 'もみじを見つけた！', rarity: 'normal', weight: 5 },
  { image: 'icho.png', text: 'イチョウを見つけた！', rarity: 'normal', weight: 5 },
  { image: 'higanbana.png', text: '彼岸花を見つけた！', rarity: 'normal', weight: 10 },
  { image: 'kuri.png', text: '栗を見つけた！', rarity: 'normal', weight: 10 },
  { image: 'yakiimo.png', text: '焼き芋を見つけた！', rarity: 'normal', weight: 10 },
  { image: 'halloween_pumpkin.png', text: 'かぼちゃのランタンを見つけた！', rarity: 'normal', weight: 10 },
  { image: 'sakura.png', text: '残念！季節外れ・桜を見つけた！', rarity: 'rare', weight: 50 },
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