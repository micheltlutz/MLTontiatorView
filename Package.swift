// swift-tools-version:4.2
//
//  MLTontiatorView.swift
//  MLTontiatorView
//
//  Created by Michel Lutz on 23/10/15.
//  Copyright © 2017 micheltlutz. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "MLTontiatorView",
    products: [
        .library(
            name: "MLTontiatorView",
            targets: ["MLTontiatorView"]),
        ],
    dependencies: [],
    targets: [
        .target(
            name: "MLTontiatorView",
            dependencies: ["UIKit"],
            path: "Sources"),
        .testTarget(
            name: "MLTontiatorViewTests",
            dependencies: ["MLTontiatorView"],
            path: "Tests")
    ]
)
