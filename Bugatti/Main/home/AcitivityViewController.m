//
//  AcitivityViewController.m
//  Bugatti
//
//  Created by toby on 31/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "AcitivityViewController.h"

@interface AcitivityViewController ()

@property (nonatomic,strong) UITextView *textView;
@end

@implementation AcitivityViewController

- (UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(LEFT_EGDE, self.navbarv_bottom+10, self.view.width-LEFT_EGDE*2, self.view.height-self.navbarv_bottom)];
        _textView.textColor = COLOR(51, 51, 51, 1);
    }
    return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"活动详情";
    self.titleAlignment = NavTitleAlignmentLeftEdge;
    self.titleColor = COLOR(51, 51, 51, 1);
    [self.view addSubview:self.textView];
    [self addGrayBackbutton];
    
    self.textView.text = @"从1990年至2010年，上海证券交易所(以下简称“上交所”)从最初的8只股票、22只债券，发展为拥有894家上市公司、938只股票、18万亿股票市值的股票市场，拥有199只政府债、284只公司债、25只基金以及回购、权证等交易品种，初步形成以大型蓝筹企业为主，大中小型企业共同发展的多层次蓝筹股市场，是全球增长最快的新兴证券市场。适应上海证券市场的发展格局，以上证综指、上证50、上证180、上证380指数，以及上证国债、企业债和上证基金指数为核心的上证指数体系，科学表征上海证券市场层次丰富、行业广泛、品种拓展的市场结构和变化特征，便于市场参与者的多维度分析，增强样本企业知名度，引导市场资金的合理配置。上证指数体系衍生出的大量行业、主题、风格、策略指数，为市场提供更多、更专业的交易品种和投资方式，提高市场流动性和有效性。[2]上证综合指数是最早发布的指数，是以上证所挂牌上市的全部股票为计算范围，以发行量为权数的加权综合股价指数。这一指数自1991年7月15日起开始实时发布，基日定为1990年12月19日，基日指数定为100点。新上证综指发布以2005年12月30日为基日，以当日所有样本股票的市价总值为基期，基点为1000点。新上证综指简称“新综指”，指数代码为000017。“新综指”当前由沪市所有G股组成。此后，实施股权分置改革的股票在方案实施后的第二个交易日纳入指数。指数以总股本加权计算。据统计，以2005年12月15日收盘价计算，“新综指”市价总值为3927亿元，流通市值为1425亿元，占市场的比重分别为18%及22%。随着股权分置改革的不断深入，“新综指”占市场比重将逐渐增大。2005年12月15日，“新综指”市盈率为12．14倍，比上证综指低23．47%。新上证综指是中国证券市场由权威机构发布的反映股权分置改革实施后公司概况的指数，随着股权分置改革的全面推进，将不断有新的样本股加入新上证综指；在不远的将来，随着市场大部分上市公司完成股改，新上证综指将逐渐成为主导市场的核心指数。2014年12月5日，两市成交量再度放量，开盘一小时，两市成交超5000亿，半日成交高达逾7000亿。截至收盘，沪市成交达6300亿，深市成交高达4300亿。成交总额创纪录超万亿。";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
