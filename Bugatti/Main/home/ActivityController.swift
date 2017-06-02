//
//  ActivityController.swift
//  Bugatti
//
//  Created by toby on 01/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

import UIKit

class ActivityController : BaseViewController,UITableViewDataSource,UITableViewDelegate{
    
    var tabView : UITableView?
    var dataArray = [String]()
    
    var _tittle: String?
    
    var tittle: String?{
        set{
            _tittle = newValue
        }
        get{
            return _tittle
        }
    }
    
    lazy var _textView: UILabel = {
        let tmpTextview:UILabel = UILabel(frame:UIScreen.main.bounds)
        tmpTextview.numberOfLines = 0
        tmpTextview.textColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        tmpTextview.text = "从1990年至2010年，上海证券交易所(以下简称“上交所”)从最初的8只股票、22只债券，发展为拥有894家上市公司、938只股票、18万亿股票市值的股票市场，拥有199只政府债、284只公司债、25只基金以及回购、权证等交易品种，初步形成以大型蓝筹企业为主，大中小型企业共同发展的多层次蓝筹股市场，是全球增长最快的新兴证券市场。适应上海证券市场的发展格局，以上证综指、上证50、上证180、上证380指数，以及上证国债、企业债和上证基金指数为核心的上证指数体系，科学表征上海证券市场层次丰富、行业广泛、品种拓展的市场结构和变化特征，便于市场参与者的多维度分析，增强样本企业知名度，引导市场资金的合理配置。上证指数体系衍生出的大量行业、主题、风格、策略指数，为市场提供更多、更专业的交易品种和投资方式，提高市场流动性和有效性。[2]上证综合指数是最早发布的指数，是以上证所挂牌上市的全部股票为计算范围，以发行量为权数的加权综合股价指数。这一指数自1991年7月15日起开始实时发布，基日定为1990年12月19日，基日指数定为100点。新上证综指发布以2005年12月30日为基日，以当日所有样本股票的市价总值为基期，基点为1000点。新上证综指简称“新综指”，指数代码为000017。“新综指”当前由沪市所有G股组成。此后，实施股权分置改革的股票在方案实施后的第二个交易日纳入指数。指数以总股本加权计算。据统计，以2005年12月15日收盘价计算，“新综指”市价总值为3927亿元，流通市值为1425亿元，占市场的比重分别为18%及22%。随着股权分置改革的不断深入，“新综指”占市场比重将逐渐增大。2005年12月15日，“新综指”市盈率为12．14倍，比上证综指低23．47%。新上证综指是中国证券市场由权威机构发布的反映股权分置改革实施后公司概况的指数，随着股权分置改革的全面推进，将不断有新的样本股加入新上证综指；在不远的将来，随着市场大部分上市公司完成股改，新上证综指将逐渐成为主导市场的核心指数。2014年12月5日，两市成交量再度放量，开盘一小时，两市成交超5000亿，半日成交高达逾7000亿。截至收盘，沪市成交达6300亿，深市成交高达4300亿。成交总额创纪录超万亿。"
        return tmpTextview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleName = "NIKKA"
        self.navbarBackgroundColor = UIColor.colortThemeGreen();
        
        
        for index in 1...20 {
            self.dataArray.append("cellTitle: \(index)")
        }
        
        let frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64)
        self.tabView = UITableView(frame:frame,style:UITableViewStyle.plain)
        self.tabView!.delegate = self
        self.tabView!.dataSource = self
        self.tabView?.tableHeaderView = self._textView
        self.tabView!.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "ActivityController_cell")
        self.view.addSubview(tabView!)
        
        self._tittle = "aaaa"
        print("title : \(self._tittle)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ActivityController_cell", for: indexPath)
        
        cell.textLabel?.text = self.dataArray[indexPath.row]
        return cell
    }
}
