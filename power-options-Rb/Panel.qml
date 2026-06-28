import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Widgets

Item {
    id: root

    property var pluginApi: null

    readonly property var geometryPlaceholder: mainContainer
    readonly property bool allowAttach: false
    readonly property bool panelAnchorHorizontalCenter: true
    readonly property bool panelAnchorVerticalCenter: true
    readonly property real panelYOffset: 140

    property real contentPreferredWidth: 280 * Style.uiScaleRatio
    property real contentPreferredHeight: column.implicitHeight + Style.marginL * 2

    property color panelBackgroundColor: Color.mSurface

    Process {
        id: shutdownProc
    }

    Process {
        id: rebootProc
    }

    Process {
        id: logoutProc
    }

    Item {
        id: mainContainer
        anchors.fill: parent

        ColumnLayout {
            id: column
            anchors {
                fill: parent
                margins: Style.marginL
            }
            spacing: Style.marginS

            NBox {
                Layout.fillWidth: true
                Layout.preferredHeight: headerRow.implicitHeight + Style.marginM * 2

                RowLayout {
                    id: headerRow
                    anchors.fill: parent
                    anchors.margins: Style.marginM
                    spacing: Style.marginS

                    NIcon {
                        icon: "power"
                        color: Color.mPrimary
                        pointSize: Style.fontSizeXL
                    }

                    NText {
                        Layout.fillWidth: true
                        text: "Opções de Energia"
                        font.weight: Style.fontWeightBold
                        pointSize: Style.fontSizeL
                        color: Color.mOnSurface
                    }

                    NIconButton {
                        icon: "x"
                        baseSize: Style.baseWidgetSize * 0.8
                        onClicked: {
                            if (root.pluginApi?.closePanel)
                                root.pluginApi.closePanel(root.pluginApi.panelOpenScreen)
                        }
                    }
                }
            }

            NButton {
                Layout.fillWidth: true
                text: "Desligar"
                onClicked: {
                    if (!root.pluginApi) return
                    shutdownProc.command = ["systemctl", "poweroff"]
                    shutdownProc.running = true
                    root.pluginApi.closePanel(root.pluginApi.panelOpenScreen)
                }
            }

            NButton {
                Layout.fillWidth: true
                text: "Reiniciar"
                onClicked: {
                    if (!root.pluginApi) return
                    rebootProc.command = ["systemctl", "reboot"]
                    rebootProc.running = true
                    root.pluginApi.closePanel(root.pluginApi.panelOpenScreen)
                }
            }

            NButton {
                Layout.fillWidth: true
                text: "Sair"
                onClicked: {
                    if (!root.pluginApi) return
                    logoutProc.command = ["loginctl", "terminate-user", Quickshell.env("USER") || "rodrigo"]
                    logoutProc.running = true
                    root.pluginApi.closePanel(root.pluginApi.panelOpenScreen)
                }
            }
        }
    }
}
