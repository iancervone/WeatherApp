//
//  DetailWeatherViewController.swift
//  WeatherApp
//
//  Created by Ian Cervone on 10/17/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {

  var dailyForecast: dataWrapper!
  
  var city = String()
  
  var cityLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 30.0, weight: UIFont.Weight.thin)
    label.textAlignment = .center
    label.backgroundColor = .red
    return label
  }()
  
  var summaryLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  var highTempLabel: UILabel = {
  let label = UILabel()
    return label
  }()
  
  var lowTempLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  var sunriseLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  var sunsetLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  var percipitationLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  var windspeedLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  var infoStack: UIStackView = {
    let stack = UIStackView()
    return stack
  }()
  
  var cityImage: UIView = {
    let view = UIView()
    return view
  }()
  
  var saveButton: UIButton = {
    let button = UIButton()
    //save button needs an alert view
    return button
  }()
  
  private func setUpSubViews() {
    self.view.addSubview(cityLabel)
    self.view.addSubview(summaryLabel)
    self.view.addSubview(highTempLabel)
    self.view.addSubview(lowTempLabel)
    self.view.addSubview(sunriseLabel)
    self.view.addSubview(sunsetLabel)
    self.view.addSubview(percipitationLabel)
    self.view.addSubview(windspeedLabel)
    self.view.addSubview(infoStack)
    self.view.addSubview(cityImage)
    self.view.addSubview(saveButton)
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpConstraints()
        setInfo()
    }
  
//SET INFO TO VIEWS
  private func setInfo() {
   cityLabel.text = city

  }
  
    
//CONSTRAINTS
  private func setUpConstraints() {
    cityLabelConstraints()
    cityImageConstraint()
    summaryLabelConstraints()
    infoStackConstraints()
  }
  
  private func cityLabelConstraints() {
    cityLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cityLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 88),
      cityLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      cityLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      cityLabel.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func cityImageConstraint() {
    cityImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cityImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 140),
      cityImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      cityImage.heightAnchor.constraint(equalToConstant: 400),
      cityImage.widthAnchor.constraint(equalToConstant: 400),
      
    ])
  }

  private func summaryLabelConstraints() {
    summaryLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      summaryLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 550),
      summaryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      summaryLabel.heightAnchor.constraint(equalToConstant: 140),
      summaryLabel.widthAnchor.constraint(equalToConstant: 300)
    ])
  }
  
  private func infoStackConstraints() {
    infoStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      infoStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 700),
      infoStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      infoStack.heightAnchor.constraint(equalToConstant: 250),
      infoStack.widthAnchor.constraint(equalToConstant: 300)
    ])
  }
  
  
  
  
}
