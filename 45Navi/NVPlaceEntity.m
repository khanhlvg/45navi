//
//  NVPlaceEntity.m
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import "NVPlaceEntity.h"
#import <MapKit/MapKit.h>

@implementation NVPlaceEntity

- (NSString *)transitString
{
    NSString *transitTypeStr;
    
    switch (self.transitType) {
        case NVTransitTypeByFoot:
            transitTypeStr = @"徒歩";
            break;
            
        case NVTransitTypeByTrain:
            transitTypeStr = @"電車で";
            break;
            
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%@ %zd分",transitTypeStr,self.transitTime];
}

- (NSInteger)transitTime
{
    if (self.route) {
        return self.route.expectedTravelTime / 60;
    }
    
    return 1000;
}

- (NVTransitType)transitType
{
    if (self.route) {
        for (MKRouteStep *step in self.route.steps) {
            //NSLog(@"transportType = %@",step.instructions);
            if (step.transportType != MKDirectionsTransportTypeWalking) {
                return NVTransitTypeByTrain;
            }
        }
    }
    
    return NVTransitTypeByFoot;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

- (NSString *)title
{
    return self.placeName;
}

+ (NSDictionary *)mockDescriptionData
{
    static NSMutableDictionary *mockDict;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mockDict = [NSMutableDictionary new];
        [mockDict setObject:@"実際のカヤックやカヌーに搭乗し、それを操作することで船の基本や知識を学ぶための施設。2008年シーズンまでは、遊泳プールとして毎年営業していた。2008年シーズンを最後に34年間の遊泳プールとしての営業に幕を閉じる事となった。女性客・カップル・子ども連れ客が多く、潮風公園や周辺施設が充実してるので、観光・買い物ついでに利用する人が多かった。" forKey:@"船の科学館体験教室プール"];
        [mockDict setObject:@"日本初の格闘技専用アリーナと銘打ち、2000年にオープンした。プロレス団体の一つである、プロレスリング・ノアが事務所、道場、合宿所を置いている。バブル期に存在・1991年に閉店したライブハウス・ディスコの「MZA有明（エムザありあけ）」と改同一建物で、ＭＺＡ有明ではM.C.ハマー・ポール・マッカートニーなどを多くの外国人タレントがライブを行った。" forKey:@"ディファ有明"];
        [mockDict setObject:@"宗谷は、日本の砕氷船である。日本海軍では特務艦、海上保安庁では灯台補給船、巡視船として服務した。日本における初代南極観測船にして、現存する数少ない旧帝国海軍艦船である。現在でも船籍を有しており、船舶法の適用対象で、必要であれば舫を解いて航行できる。現在も海上保安庁特殊救難隊の訓練施設として使用されている。船名は北海道北部の宗谷岬と樺太の間にある宗谷海峡にちなんで名づけられた。" forKey:@"宗谷 (船)"];
        [mockDict setObject:@"埋立地の帰属は未決。現在は江東区と大田区が帰属主張している。江東区は「先に第二航路トンネルで結ばれており、それによる車の渋滞や騒音に耐えてきたため、江東区の帰属がふさわしい」と主張。大田区は「前の漁業組合が養殖の漁業権を持っていて、埋め立てのために泣く泣く放棄をした。羽田空港との兼ね合いを考えると大田区の帰属がふさわしい」と主張。本件未解決のため埋立地内にある施設は住所が決められていない。" forKey:@"中央防波堤内側埋立地"];
        [mockDict setObject:@"1992年（平成4年）の開場時は「アートスフィア」という名称であったが、2006年（平成18年）4月に運営会社が株式会社スフィアからホリプロのグループ会社である株式会社銀河劇場になった際にリニューアルされて同年10月に天王洲 銀河劇場としてリニューアルオープンとなった。馬蹄形三層構造の吹き抜けの劇場。舞台と客席の距離が最大でも20メートルという近さが特徴。ボックス席が2階と3階に設けられている。" forKey:@"天王洲銀河劇場"];
        [mockDict setObject:@"東京都は、築地市場が取り扱い数量の拡大により施設が手狭になったことや施設老朽化、銀座などに近い築地という立地の良さなどを鑑み、2014年を目処に東京都江東区豊洲への移転が検討されている。東京都側と築地市場業界との協議機関として、新市場建設協議会が設置されており、2004年7月、「豊洲新市場基本計画」が策定された。" forKey:@"豊洲新市場"];
        [mockDict setObject:@"雲鷹丸（うんようまる）は日本の船舶であり、漁業練習船および漁業調査船として使用された、3本マストの帆船である。捕鯨実習をはじめ、漁業調査、学生実習、漁撈技術・漁具開発等に貢献をし、漁獲物処理では船上でのカニ缶詰製造に成功し、後の大型蟹工船の先駆けとなった。1998年（平成10年）12月11日に国の登録有形文化財として登録された[6][5]。" forKey:@"雲鷹丸"];

    });
    
    return mockDict;
}

- (NSString *)explanation
{
    if (!_explanation) {
        return [self.class mockDescriptionData][self.placeName];
    }
    
    return _explanation;
}

@end
