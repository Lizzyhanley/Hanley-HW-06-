//
//  DayWeatherCell.swift
//  WeatherGift
//
//  Created by CSOM on 4/1/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {

    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellWeekday: UILabel!
    @IBOutlet weak var cellMaxTemp: UILabel!
    @IBOutlet weak var cellMinTemp: UILabel!
    @IBOutlet weak var cellSummary: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

    func configureTableCell(dailyForcast: WeatherLocation.DailyForcast, timeZone: String) {
        cellMaxTemp.text = String(format: "%2.f", dailyForcast.dailyMaxTemp) + "°"
        cellMinTemp.text = String(format: "%2.f", dailyForcast.dailyMinTemp) + "°"
        cellSummary.text = dailyForcast.dailySummary
        cellIcon.image = UIImage(named: dailyForcast.dailyIcon)
        let usableDate = Date(timeIntervalSince1970: dailyForcast.dailyDate)
        let dailyTimeZone = TimeZone(identifier: timeZone)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = dailyTimeZone
        let weekDay = dateFormatter.string(from:usableDate)
        cellWeekday.text = weekDay
    }
    
}
