/*
 * Copyright (C) 2014 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Ubuntu.Components 0.1
import Unity 0.2
import "../Components"

Item {
    id: root

    property alias scope: scopeView.scope

    property ListModel searchHistory

    signal back
    signal gotoScope(string scopeId)
    signal openScope(var scope)

    Item {
        id: scopeViewHolder
        anchors.fill: parent

        GenericScopeView {
            id: scopeView
            width: parent.width
            height: parent.height
            isCurrent: scope != null
            tabBarHeight: scopeItemPageHeader.implicitHeight
            pageHeader: scopeItemPageHeader
            openEffect: openEffect
            previewListView: previewListView

            Connections {
                target: isCurrent ? scope : null
                onGotoScope: root.gotoScope(scopeId);
                onOpenScope: root.openScope(scope);
            }
        }

        PageHeader {
            id: scopeItemPageHeader
            width: parent.width
            searchEntryEnabled: true
            searchHistory: root.searchHistory
            scope: root.scope
            height: units.gu(7)

            childItem: Row {
                anchors {
                    fill: parent
                    leftMargin: units.gu(2)
                }
                spacing: units.gu(1)
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: "graphics/dashback.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.back();
                    }
                }
                Label {
                    id: label
                    anchors.verticalCenter: parent.verticalCenter

                    text: scope ? scope.name : ""
                    color: "grey"
                    font.family: "Ubuntu"
                    font.weight: Font.Light
                    fontSize: "x-large"
                    elide: Text.ElideRight
                    style: Text.Raised
                    styleColor: "black"
                }
            }
        }
    }

    DashContentOpenEffect {
        id: openEffect
        anchors {
            fill: parent
            bottomMargin: -bottomOverflow
        }
        sourceItem: scopeViewHolder
        previewListView: previewListView
    }

    PreviewListView {
        id: previewListView
        openEffect: openEffect
        categoryView: scopeView.categoryView
        pageHeader: scopeItemPageHeader
        scope: root.scope
        anchors.fill: parent
    }
}
