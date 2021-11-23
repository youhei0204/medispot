# frozen_string_literal: true

USER_NUM = 30
SAMPLE_USER_IMAGE_NUM = 21
SAMPLE_REVIEW_IMAGE_NUM = 21
MIN_IMAGE_NUM_OF_REVIEW = 0
MAX_IMAGE_NUM_OF_REVIEW = 3
MIN_LIKE_NUM_PER_USER = 8
MAX_LIKE_NUM_PER_USER = 13
MIN_REVIEW_NUM_PER_SPOT = 3
MAX_REVIEW_NUM_PER_SPOT = 10

introduction_pattern = [
  "このご時世ですので、家でできる趣味を探しに始めました。",
  "よろしくお願いします。",
  "最近の流行りに乗って見ました。",
  "筋トレ、瞑想、家族サービス！",
  "会社でも瞑想週間というものが始まりました。乗るしかないですね、このビッグウェーブに",
  "会社で流行ってたのではじめました。",
  "気になっている人が健康オタクなので、話題作りに始めて見ました。",
  "瞑想は心がスッキリして良いですね。みなさんのレビューとても参考になります！",
]
title_pattern = [
  "結構よい場所でした", "初めての瞑想体験", "ちょっと感動しました",
  "コロナ禍のストレス解消に", "1人でもOKでした", "あ…ありのまま 今起こった事を話すぜ！",
  "週末の良い気分転換になりました",
  "あたらしい趣味が見つかったかも",
  "頭で考えないこと！",
  "じっとするのも案外大変だ",
  "弟について行きました",
  "何するの？って感じだったけど",
  "グッドスマイルな先生がいました。",
  "いつもと少し違う休日を",
  "新たな趣味と友達探しに",
  "足が尋常ではなく痺れた",
  "こういうのもたまには良いですね",
  "老若男女問わず楽しめる場所",
  "名状しがたい",
  "スッと気が楽に",
  "感謝の気持ちが沸いてくる",
  "植物の心のような",
  "妻に促されて通い始めました",
  "日々の仕事疲れの癒しに...",
  "リピート推奨です！",
  "自然光に包まれて"
]
content_pattern = [
  "初めての瞑想講座でした。こちらでの体験を参考にして、毎日寝る前に5分間の瞑想を行なっています。
  個人的に一番効果を感じているのは、「寝付きが良くなった」という点です。
  私は昔から寝るのが下手くそで、ベッドに入ってから数時間眠れず過ごしてしまう、なんてことがザラにあります。
  そんなとき、グータラ本を読んだりせずに瞑想をすると、自然と心が落ち着き、寝る体勢に心が落ち着きます。
  よく「心の筋トレ」と表現されることがある瞑想ですが、少し意味が理解できた気がします。
  他の方の体験談も読んでみたいですね。",
  "瞑想ってどんなもの？まったくわからないまま、とりあえず足を運んでみました。
  「興味を持ったら即アクション」が私の基本姿勢です。教室に着くと、
  すでに何人かの参加者が先生の到着を待っていました。
  中には挨拶を交わし合う人達もいて、常連さん達かな？としばらく見ていると、何人かヨガマットの上に座り、徐に準備体操を始めました。

  瞑想って準備体操が必要なの？と、思ったときには口に出ていました。
  「瞑想に準備体操は必要ないけど、これをやると入りやすくなるんだよ」
  1人のおじさんが答えてくれました。
  「入るって、何にですか？」
  「ん〜、言葉にし辛いんだけど、そういう表現がぴったりなポイントがあるんだよ。
  そこに一旦入ると、意識がガラッと変わって、視界が開けるんだ」
  「はは、そういうものなのですね」
　
  なんだか怪しい宗教みたいだな、と今度は口に出さずにいると、
  ガラガラというドア音と共に、30代くらいの女性が入ってきました。
  「あ、先生！久しぶり」おじさんが会話を切り上げて言いました。
  「お久しぶりです〜！みなさんも、今日はお越しいただきありがとうございます！」
  先生と呼ばれたその人は、私たち一人一人に目を合わせながら、慣れた様子で挨拶を始めました。
　
  思ったより若くて快活な人が先生なんだな、というのが私の正直な第一印象です。
  白状すると、私の瞑想に対するイメージは、仙人のポーズだのポケモンの技だのといった頓珍漢なイメージに加え、
  昼間にカーテン閉め切ってやる根暗なアクティビティという決めつけから、あまり明るいイメージではなかったのです。
  興味をもったのは、単純に一流進学校や世界的企業が瞑想を習慣として取り入れている、という話を小耳に挟んだのがきっかけでした。
　
  そんなことを思いながら話を聞いていると、先生と目が合いました。
  「初めましてですね。今日はステキな体験をプレゼントできるように、私も精一杯がんばりますね」
  「あ、はい！よろしくお願いします！」
  独特な言い方をする人だな、と思いました。初見の方は私含めて5人で、全体の1/3ほどのようで、一人一人に話しかけていました。
　　
  友達同士できている人もいるらしく、こんなザワザワした中で始まるのかと思っていましたが、
  実際にレッスンが始まったとたん、部屋はシンと静まりかえりました。
  談笑していた人もピタっと静まり、皆目を閉じてじっと座っています。自分の世界に篭るというか、
  ザ・瞑想といったポーズのまま微動だにしなくなりました。
  少しトーンダウンした先生の声だけが響き、呼吸の説明や、意識するべきポイント、すべきでないポイントを説明して行きます。
  私は正直、慣れない空気に圧されて周りを見ては落ち着かないといった様子でしたが、
  せっかく来たからとそのまま先生の指示通りのことをしてみました。
　
  見様見真似でやっているうちに、レッスン時間の30分が過ぎて行きました。
  座ってじっとしている時間としては長いものでしたが、意外にもあっという間の時間でした。
  肝心の瞑想効果ですが、、、正直わかりませんでした！強いて言えば、少しスッキリしたかな？
  そもそも、”ジッとしている”ということが結構難しい。瞑想以前に、ここに最初の壁を感じました！
  電車の中でスマホや本を開かずに、ただジッとしているのが難しいという人は、私と同じ感想を持つかもしれません。
　
  これが私の初めての瞑想体験です。
  先生曰く、練習が必要とのことで最初は仕方がないらしいです。
  こんなものかと思いきや、瞑想後の周りの人たちの表情をみていると、なにか瞑想前とは違ったものを感じます。
  顔がスッキリしていて、ポジティブ感が増したように見えました。
  これが中々名状し難いのですが、心のチューニングのようなものかなと感じました。
  でも、それが何の役に立つのか？まだまだ疑問です。考えるより今後も通ってみようと思います。
  今回はそんな感想を持って教室を後にしました。劇的な体験とは行きませんでしたが、これからが楽しみです。
  みなさんのレビューも参考にしつつ、色々巡ってみるのもアリですね。",
  "先生が丁寧に説明してくれたので、初心者でも安心でした。指示通りに見様見真似でやっているうちに、あっという間に時間が過ぎて行きました。

  肝心の瞑想効果ですが、、、心がかなりスッキリしました！私は考え事をしやすいタイプなので、
  こんな風に何も考えず、今を感じることに集中する時間は大切にすべきだなと思いました。
  でも、瞑想できてる！という実感にはまだまだ遠いかな。
  それにしても”ジッとしている”というのは結構大変ですね。正直、ここが肝ですね！",
  "きっかけはコロナ禍によるストレスなのか、不眠気味で、寝てもスッキリしない日が続いていたからです。
  そこで、不眠解消方法を色々と調べてみたところ「瞑想すれば気持ちが落ち着き安眠できる」というネットの記事を読んで、費用もあまり掛からなそうだし、試しに体験してみようと思い、教室へ足を運びました。
  また、私は運動が苦手なので、激しく身体を動かすことのない瞑想であれば出来るかなと、軽い気持ちで挑戦してみました。
   
  当日教室に行くと、私以外の皆さんは経験者のようで、慣れたように各々準備運動をしていました。
  何も知らない私も見様見真似で準備運動をしてみましたが、ヨガマットの上で準備運動をしただけで、瞑想前なのに達成感を味わってしまいました（笑）
   
  瞑想が始まると、初めは先生の説明が多く、もっと静かに進むものかと思っていたので意外でした。
   
  しかし、瞑想が進むにつれて、いつの間にか集中力が高まり、先生の話が聞こえているけれども気にならない状態、無の境地といえば大袈裟ですが、そんな感覚になっていた気がします。
   
  あっという間に瞑想の時間は終わり、終わった後は少し肩の力が抜けた気がします。
  何も考えずに過ごすだけで、こんなにも身体に変化を与えるものなのかと非常に驚きました。
   
  今では不眠気味は解消し、安眠して過ごしています。今後も瞑想習慣を続けていきたいと思います。",
  "何度か通っていますが、初めてレビューを書かせていただきます！
  昨年から在宅ワークが多くなり、家にいる時間が増えたため、余暇の時間でできることはないか探した結果こちらに出会いました。
  日々の運動不足解消だけではなくメンタル調整としても利用しています。
  講座の内容や効果については他の方の記載がある通り、日々の生活から少し距離を置いたような、穏やかな時間を過ごすことができます。
  また駅から近く繁華街の中にあることから通いやすいという利点もあり、余暇に友達を誘って、なんてこともしばしば。
  1人で行うイメージが強いですが、友達やカップルで来ている方もチラホラ見かけます。",
  "初心者向けのスポットです。
  先生も優しく教えてくれて、時間はあっという間に感じます。
  初めて行ったときは、意外とじっとしているのが大変なことに気づくかと思います。
  かく言う私もそんな一人です。友人に連れられ行ってみると、結構大変でした。
  しかし先生からもいいお話を聞けたり、体もリラックスでき、ストレス社会を生き抜くにはとても良い趣味だと思いました。
  ヨガなどは自宅でもできるので、出歩くのが苦手な人にもおすすめです。瞑想もコツをつかめば後は自宅や近所の公園でもできる趣味なので、初心者の方は試してみるのもありです。",
  "瞑想することを始めたのは約1年前です。
  友人の紹介でこちらの教室に行ったのがきっかけで、それ以降何度か通ったら、ハマってしまいヨガやスポーツクラブへも通い始めました。
    
  最近はコロナも落ち着いてきたので、よく外出し、日の当たる公園で、瞑想しながらのんびり過ごすのが楽しみです。今回行ってきたのは、江戸川区の南部にある葛西臨海公園。水族館などもあり、週末は家族連れやカップルがやってきています。
  とにかく敷地が広いので、静かな場所を探すといろんなところに良いスポットがあります。最近は少し肌寒くなってきましたが、日の当たる場所も多いです。
    
  そんな日光浴も楽しみながら、園内のベンチで静かに瞑想。
  流れる風の音と葉が揺れる音、また海も近いため、海の音に引き込まれながら、一人の世界へ。
  瞑想の先生に教わった呼吸法も行いながら、自然光に包まれて瞑想することで、日々の疲れやストレスも浄化されていきました。
  その後園内を散歩。
  駅近くにはスターバックスもあり、飲みながら園内へというのもいいものです。
  観覧車からの眺めはよく、社内で景色を楽しみつつ、物思いにふけるのも乙なものです。
  公園内はほんとに敷地が広いので、可能なところは自転車等で移動することをお勧めします。
  外での瞑想好きな方はおすすめです。上級者向きかもしれません。"
]

USER_NUM.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    introduction: introduction_pattern.sample,
    password: "123123",
    password_confirmation: "123123",
    confirmed_at: Time.now
  )
  user.image.attach(
    io: File.open(
      Rails.root.join("app/assets/images/seeds/profile/user_#{rand(1..SAMPLE_USER_IMAGE_NUM)}.jpg")
    ),
    filename: 'profile.jpg',
  )
end

User.create!(
  name: "フグ田 マスオ",
  email: "mso_masuo@email.com",
  introduction: "原作では当初博多に住んでいましたが、お父さんの転勤に伴って東京に引っ越しました。",
  password: "123123",
  password_confirmation: "123123",
  confirmed_at: Time.now
)
User.find_by(email: 'mso_masuo@email.com').image.
  attach(io: File.open(
    Rails.root.join("app/assets/images/seeds/profile/masuo.jpg")
    ),filename: 'profile.jpg',
  )

colors = ['red', 'blue', 'yellow', 'purple', 'green']
colors_to_jp = { 'red' => '赤', 'blue' => '青', 'yellow' => '黄', 'purple' => '紫', 'green' => '緑' }
colors.each do |color|
  user = User.create(
    name: "ゲスト(#{colors_to_jp[color]})",
    email: "guest_#{color}@medispot.com",
    introduction: "ゲスト(#{colors_to_jp[color]})としてログインしています。",
    password: SecureRandom.urlsafe_base64,
    new_notification_flag: true,
    confirmed_at: Time.now
  )
  user.notifications.create(
    request_type: 0,
    subject: 'ようこそMediSpotへ！',
  )
  user.image.attach(
    io: File.open(
      Rails.root.join("app/assets/images/seeds/profile/guest_#{color}.jpg")
    ),
    filename: 'profile.jpg',
  )
end


Spot.create!(
  name: "リベルテ・パティスリー・ブーランジェリ－ 東京吉祥寺",
  address: "東京都武蔵野市吉祥寺本町２丁目１４−3 1F･2F",
  place_id: "ChIJn2tfz0juGGARTnstC_K9i4Y",
  lat: 35.7059,
  lng: 139.577,
)
Spot.create!(
  name: "muon Shinjuku",
  address: "東京都新宿区西新宿１丁目２１−１ 明宝ビルディング 2F",
  place_id: "ChIJw_q_tiKNGGARIldeNZDbatE",
  lat: 35.6884,
  lng: 139.696,
)
Spot.create!(
  name: "HIDECOの東京ヒプノセラピー/瞑想講座/レイキヒーリングサロン",
  address: "東京都中央区日本橋人形町１丁目１−番２２号 恩田 ビル ９０１",
  place_id: "ChIJIXVAOUWJGGARgMiICCLnFsg",
  lat: 35.6843,
  lng: 139.782,
)
Spot.create!(
  name: "瞑想サロン MIROKU51",
  address: "東京都中央区銀座３丁目８−１０ 銀座朝日ビル4F",
  place_id: "ChIJU4VceCeLGGARa45Sc1Ml-a4",
  lat: 35.6713,
  lng: 139.767,
)
Spot.create!(
  name: "一法庵",
  address: "神奈川県鎌倉市稲村ガ崎１丁目９",
  place_id: "ChIJ-bcdjbxPGGAR6D-I-kllz58",
  lat: 35.3036,
  lng: 139.525,
)
Spot.create!(
  name: "全生庵",
  address: "東京都台東区谷中５丁目４−７ 全生庵",
  place_id: "ChIJtbB5atONGGARS2lb1uRdhXw",
  lat: 35.724,
  lng: 139.767,
)
Spot.create!(
  name: "ZEN VAGUE",
  address: "神奈川県鎌倉市長谷２丁目７−２９",
  place_id: "ChIJpWSG2O9FGGARvv5ds9Cysb4",
  lat: 35.3111,
  lng: 139.538,
)
Spot.create!(
  name: "香林院",
  address: "東京都渋谷区広尾５丁目１−２１",
  place_id: "ChIJKT4_IG2LGGARMn9DEVzupDk",
  lat: 35.6497,
  lng: 139.719,
)
Spot.create!(
  name: "Medicha │ Meditation Studio（メディテーション スタジオ）",
  address: "東京都港区南青山５丁目３−１８ ブルーサンクポイントＣ棟 B1F",
  place_id: "ChIJgYyx5bGLGGARwsRcIgFUMd0",
  lat: 35.6628,
  lng: 139.716,
)
Spot.create!(
  name: "True Nature Meditation",
  address: "東京都渋谷区千駄ケ谷１丁目１３−１１ 1F",
  place_id: "ChIJ3QHJApaMGGARahOkvQqm2hM",
  lat: 35.6771,
  lng: 139.712,
)
Spot.create!(
  name: "鎌倉ヨガ教室",
  address: "神奈川県鎌倉市稲村ガ崎１０",
  place_id: "ChIJYwXTYl5PGGAR8SCTYtUo0L4",
  lat: 35.3106,
  lng: 139.524,
)
Spot.create!(
  name: "MELON ー マインドフルネスサロン",
  address: "東京都渋谷区東２丁目２３−８ 渋谷ＭＭＩビル 1階",
  place_id: "ChIJQeuws06NGGART_25z6aD0fk",
  lat: 35.6531,
  lng: 139.709,
)
Spot.create!(
  name: "メディテイション with ナチュラルヨガ 東京センター",
  address: "東京都荒川区町屋１丁目８−１８",
  place_id: "ChIJRcc6gm2OGGARTNYDeUnxAQo",
  lat: 35.7456,
  lng: 139.783,
)
Spot.create!(
  name: "瞑想スペースAOYAMA",
  address: "東京都港区南青山２丁目１０−６ 外苑ビル ３F",
  place_id: "ChIJP3pR0YKMGGARG_GQIQeUuU4",
  lat: 35.671,
  lng: 139.721,
)
Spot.create!(
  name: "瞑想コミュニティ西荻窪・ELM瞑想（フルフィルメント瞑想）",
  address: "東京都杉並区西荻南２丁目１８−１７ キャッスル 西荻 204 号室",
  place_id: "ChIJZeqeSgXuGGARhGibPhy-oyM",
  lat: 35.7004,
  lng: 139.599
)
Spot.create!(
  name: "瞑想カフェ 気づき",
  address: "東京都渋谷区円山町５−６ 道玄坂イトウビル6F",
  place_id: "ChIJS_AG3_mLGGARCeS_2SrbtCI",
  lat: 35.6566,
  lng: 139.695,
)
Spot.create!(
  name: "マインドブリス",
  address: "東京都港区新橋２丁目２０−１５ 新橋駅前ビル1号館 208号",
  place_id: "ChIJnWuXIwSLGGARWrLmS_iUa2E",
  lat: 35.6662,
  lng: 139.76,
)
Spot.create!(
  name: "アーナンダ・ヨーガ 新橋クラス",
  address: "東京都港区西新橋３丁目8−１ スペース銀の鈴 第二鈴丸ビル 6F",
  place_id: "ChIJFUzazLWLGGAR5omH0S4Lfbc",
  lat: 35.6649,
  lng: 139.753,
)
Spot.create!(
  name: "金地院坐禅道場",
  address: "東京都港区芝公園３丁目５−２３",
  place_id: "ChIJlVHXM5aLGGARPdl2ng7c4Mg",
  lat: 35.66,
  lng: 139.745,
)
Spot.create!(
  name: "ホットヨガサロン・ラビエ・錦糸町店",
  address: "東京都墨田区江東橋４丁目２５−７",
  place_id: "ChIJ50Izu9mIGGARxYAd_uSP2CA",
  lat: 35.6955,
  lng: 139.817,
)
Spot.create!(
  name: "herb steam Padmini",
  address: "千葉県市川市市川１丁目２６−１５ 花亀ビル 1階",
  place_id: "ChIJqae5GauHGGARu1YJNSKWNj8",
  lat: 35.7317,
  lng: 139.911,
)
Spot.create!(
  name: "Padmini Japan Ayurveda",
  address: "千葉県安房郡鋸南町竜島９７３−９",
  place_id: "ChIJF_QKkXYdGGARoqgeJdR49fs",
  lat: 35.1152,
  lng: 139.828,
)
Spot.create!(
  name: "Flow Arts Yoga Studio",
  address: "東京都目黒区中目黒１丁目３−５ 目黒プリンスコーポ203",
  place_id: "ChIJvzTRG0aLGGAR11DZeYPNhhM",
  lat: 35.6456,
  lng: 139.702,
)
Spot.create!(
  name: "タイ仏教瞑想センター",
  address: "東京都荒川区荒川３丁目７８−５",
  place_id: "ChIJq6o-DNaNGGAR6KpBvHPTQ2M",
  lat: 35.7363,
  lng: 139.777,
)
Spot.create!(
  name: "アーユルヴェーダサロン＆スクールRavi",
  address: "東京都台東区上野７丁目９−２ ル・リオン上野ステーションコート",
  place_id: "ChIJ4e8fw5uOGGARq23YLQkjWPk",
  lat: 35.7149,
  lng: 139.779,
)
Spot.create!(
  name: "アーユルヴェーダ エクスパンスSPA 銀座中央通り店",
  address: "東京都中央区銀座７丁目９−１１ モンブラン銀座ビル ８F",
  place_id: "ChIJKyl-PVWLGGARGujrhyYlLB8",
  lat: 35.6685,
  lng: 139.762,
)
Spot.create!(
  name: "まいあさ瞑想",
  address: "東京都渋谷区代々木１丁目５３−４ 奨学会館別館5階",
  place_id: "ChIJYfCdDF6NGGARl1uMLX6wNaY",
  lat: 35.6843,
  lng: 139.7,
)
Spot.create!(
  name: "東京 港区の瞑想 気瞑想サロン・ホリスティックサロン ファビュラボ",
  address: "東京都港区赤坂４丁目４−６ パール赤坂 ３０１",
  place_id: "ChIJV0yjUkSNGGARP855_MMzeSg",
  lat: 35.6738,
  lng: 139.735,
)
Spot.create!(
  name: "Little Lotus Yoga Studio",
  address: "東京都江東区亀戸５丁目-１５-４ ５１０ビル 401",
  place_id: "ChIJ7ZN-ttaJGGARmCc3gfEucPg",
  lat: 35.7002,
  lng: 139.826,
)
Spot.create!(
  name: "テイクイットイージー",
  address: "東京都新宿区原町２丁目７０−１１",
  place_id: "ChIJy4Rj1vyMGGARBOf5wVvtkYA",
  lat: 35.7026,
  lng: 139.722,
)

Spot.all.each do |spot|
  User.all.sample(rand(MIN_REVIEW_NUM_PER_SPOT..MAX_REVIEW_NUM_PER_SPOT)).each do |user|
    user.reviews.create!(
      title: title_pattern.sample,
      content: content_pattern.sample,
      rate: rand(2..5),
      spot_id: spot.id,
      created_at: Time.now - 60 * rand(0..5) - 3600 * rand(0..5) - 86400 * rand(0..2),
    )
  end
end

Review.all.each do |review|
  [*(1..SAMPLE_REVIEW_IMAGE_NUM)].
    sample(rand(MIN_IMAGE_NUM_OF_REVIEW..MAX_IMAGE_NUM_OF_REVIEW)).each do |n|
    review.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds/review/review_#{n}.jpg")),
      filename: 'review.jpg',
    )
  end
end

User.all.each_with_index do |user, i|
  Review.all.sample(rand(MIN_LIKE_NUM_PER_USER..MAX_LIKE_NUM_PER_USER)).each do |review|
    user.likes.create!(review_id: review.id)
  end
end
