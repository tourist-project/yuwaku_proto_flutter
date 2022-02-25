

class HomePageItem{
  final String? title , eng_title, explain, image;

  HomePageItem({
    this.title,
    this.eng_title,
    this.explain,
    this.image
  });

  List<HomePageItem> homeItems = [
    HomePageItem(title: '氷室小屋', eng_title: "Himurogoya",
        explain: '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
            '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
            'できるイベントが開催されます。',
        image: 'assets/images/HimuroGoya.png'
    ),
    HomePageItem(title: '金沢夢二館', eng_title: "KanazawaYumejikan",
        explain: '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
            'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
        image: 'assets/images/Yumezikan.png'
    ),
    HomePageItem(title: '総湯', eng_title: "Soyu",
        explain: '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
            '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
        image: 'assets/images/KeigoSirayu.png'
    ),
    HomePageItem(title: '足湯', eng_title: "Ashiyu",
        explain: '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
            'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
        image: 'assets/images/Asiyu(temp).png'
    ),
    HomePageItem(title: 'みどりの里', eng_title: "Midorinosato",
        explain: 'みどりの里では、蕎麦打ち体験や梨の収穫体験などの様々なイベントが`1年を通して'
            '行われます。毎週日曜日と水曜日(4月中旬〜12月中旬)には湯涌朝市が開催され、非常に賑わって'
            'おります。湯涌の新鮮な農作物や加工品などをお買い求めいただけます。',
        image: 'assets/images/MidorinoSato.png'
    ),


  ];

}