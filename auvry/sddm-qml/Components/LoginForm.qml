// Config created by Keyitdev https://github.com/Keyitdev/sddm-astronaut-theme
// Copyright (C) 2022-2025 Keyitdev
// Distributed under the GPLv3+ License https://www.gnu.org/licenses/gpl-3.0.html

import QtQuick 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0 as SDDM

RowLayout {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    spacing: root.width * 0.04

    // left spacer — centers the two columns on screen
    Item { Layout.fillWidth: true }

    // ── LEFT COLUMN: avatar + clock ──────────────────────────────────────
    ColumnLayout {
        id: leftColumn
        Layout.preferredWidth: root.width * 0.32
        Layout.fillHeight: true
        spacing: 16

        Item { Layout.fillHeight: true }

        // Square avatar with slight rounded corners
        Rectangle {
            id: avatarBox
            Layout.alignment: Qt.AlignHCenter
            width: root.height / 7
            height: root.height / 7
            radius: 14
            color: config.FormBackgroundColor
            border.color: config.HighlightBorderColor
            border.width: 2
            layer.enabled: true
            layer.smooth: true

            Image {
                anchors.fill: parent
                anchors.margins: 2
                source: Qt.resolvedUrl("../Assets/fugue_cute.jpeg")
                fillMode: Image.PreserveAspectCrop
                smooth: true
                mipmap: true
            }
        }

        Clock {
            id: clock
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }

    // ── RIGHT COLUMN: login panel ────────────────────────────────────────
    Item {
        id: rightPanel
        Layout.alignment: Qt.AlignVCenter
        Layout.preferredWidth: root.width * 0.27
        Layout.preferredHeight: panelColumn.implicitHeight + 56

        // Frosted glass panel
        Rectangle {
            anchors.fill: parent
            color: config.FormBackgroundColor
            opacity: 0.82
            radius: 18
            border.color: config.HighlightBorderColor
            border.width: 1
        }

        // Top accent line
        Rectangle {
            width: parent.width * 0.55
            height: 2
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 1
            color: config.HighlightBorderColor
            opacity: 0.9
        }

        ColumnLayout {
            id: panelColumn
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            spacing: 2

            Input {
                id: input
                Layout.fillWidth: true
            }

            SystemButtons {
                id: systemButtons
                Layout.alignment: Qt.AlignHCenter
                exposedSession: input.exposeSession
            }

            SessionButton {
                id: sessionSelect
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: root.height / 54
                Layout.maximumHeight: root.height / 54
            }

            VirtualKeyboardButton {
                id: virtualKeyboardButton
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: root.height / 30
                Layout.maximumHeight: root.height / 30
            }
        }
    }

    // right spacer — mirrors the left spacer to keep columns centered
    Item { Layout.fillWidth: true }
}
