//
//  ViewController.swift
//  LunarCalendar
//
//  Created by NKG on 2019/11/1.
//  Copyright © 2019 NewmanYork. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADUnifiedNativeAdLoaderDelegate{
    
    /// The table view items.
    var tableViewItems = [AnyObject]()

    /// The ad unit ID from the AdMob UI.
    let adUnitID = "ca-app-pub-3940256099942544/8407707713"

    /// The number of native ads to load (must be less than 5).
    let numAdsToLoad = 5

    /// The native ads.
    var nativeAds = [GADUnifiedNativeAd]()

    /// The ad loader that loads the native ads.
    var adLoader: GADAdLoader!
    
//    var lunarDates:[DateItem] = []
    
    @IBOutlet var lunarTableView: UITableView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        lunarTableView.register(UINib(nibName: "UnifiedNativeAdCell", bundle: nil),
        forCellReuseIdentifier: "UnifiedNativeAdCell")
        lunarTableView.delegate = self
        lunarTableView.dataSource = self
        var increaseDate : Date
        for i in 1...100 {
            increaseDate = Calendar.current.date(byAdding: .day, value: i, to: Date())!
            let dt = DateItem(date : BaseCalender.getSolarDate(date: increaseDate),
                                 lundar : BaseCalender.getLunarDate(solarDate: increaseDate),
                                 suitable : "AB",
                                 notSuitable : "CC")
            tableViewItems.append(dt)
        }
        
        // Load the menu items.
        let options = GADMultipleAdsAdLoaderOptions()
        options.numberOfAds = numAdsToLoad
        
        // Prepare the ad loader and start loading ads.
        adLoader = GADAdLoader(adUnitID: adUnitID,
                               rootViewController: self,
                               adTypes: [.unifiedNative],
                               options: [options])
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }
    
    func addNativeAds() {
        if nativeAds.count <= 0 {
            return
        }
        
        let adInterval = (tableViewItems.count / nativeAds.count) + 1
        var index = 0
        for nativeAd in nativeAds {
            if index < tableViewItems.count {
                tableViewItems.insert(nativeAd, at: index)
                index += adInterval
            } else {
                break
            }
        }
    }
    
    //MARK : UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let menuItem = tableViewItems[indexPath.row] as? DateItem {

          let reusableMenuItemCell = tableView.dequeueReusableCell(withIdentifier: "Cell",
              for: indexPath) as! DateTableViewCell

            reusableMenuItemCell.dateLabel?.text = menuItem.date
            reusableMenuItemCell.lunarLabel?.text = menuItem.lundar
            reusableMenuItemCell.suitableLable?.text = menuItem.suitable
            reusableMenuItemCell.notSuitableLable?.text = menuItem.notSuitable

            return reusableMenuItemCell
        } else {
            let nativeAd = tableViewItems[indexPath.row] as! GADUnifiedNativeAd
            /// Set the native ad's rootViewController to the current view controller.
            nativeAd.rootViewController = self

            let nativeAdCell = tableView.dequeueReusableCell(
              withIdentifier: "UnifiedNativeAdCell", for: indexPath)

            // Get the ad view from the Cell. The view hierarchy for this cell is defined in
            // UnifiedNativeAdCell.xib.
            let adView : GADUnifiedNativeAdView = nativeAdCell.contentView.subviews
            .first as! GADUnifiedNativeAdView

            // Associate the ad view with the ad object.
            // This is required to make the ad clickable.
            adView.nativeAd = nativeAd

            // Populate the ad view with the ad assets.
            (adView.headlineView as! UILabel).text = nativeAd.headline
            (adView.priceView as! UILabel).text = nativeAd.price
            if let starRating = nativeAd.starRating {
            (adView.starRatingView as! UILabel).text =
                starRating.description + "\u{2605}"
            } else {
            (adView.starRatingView as! UILabel).text = nil
            }
            (adView.bodyView as! UILabel).text = nativeAd.body
            (adView.advertiserView as! UILabel).text = nativeAd.advertiser
            // The SDK automatically turns off user interaction for assets that are part of the ad, but
            // it is still good to be explicit.
            (adView.callToActionView as! UIButton).isUserInteractionEnabled = false
            (adView.callToActionView as! UIButton).setTitle(
            nativeAd.callToAction, for: UIControl.State.normal)

            return nativeAdCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "showDetail", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.lunarTableView.indexPathForSelectedRow
            
            ((segue.destination) as! DailyInfoViewController).index = indexPath
        }
    }
    
    // MARK : GADUnifiedNativeAdLoaderDelegate
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        nativeAds.append(nativeAd)
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
    }
    
    func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
        addNativeAds()
        lunarTableView.reloadData()
    }
    
}

