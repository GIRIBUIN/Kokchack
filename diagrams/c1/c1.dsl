workspace "KokChack - System Context" {

    model {
        owner = person "사장" {
            description "매장을 운영하고 발주, 지급 및 거래원장을 관리하는 사용자"
        }

        employee = person "직원" {
            description "매장에 소속되어 필요한 품목의 발주를 요청하는 사용자"
        }

        supplier = person "거래처" {
            description "사장으로부터 발주 내용을 전달받는 거래처"
        }

        kokchack = softwareSystem "KokChack" {
            description "소규모 자영업자를 위한 매장 발주 및 장부 관리 서비스"
        }

        messaging = softwareSystem "외부 메시징 서비스" {
            description "카카오톡, SMS, 이메일 등 기존 메시징 서비스"
        }

        employee -> kokchack "품목을 조회하고 발주를 요청한다"
        owner -> kokchack "매장, 주문, 지급 및 거래원장을 관리한다"

        kokchack -> owner "발주 요청 알림 및 발주 메시지를 제공한다"

        owner -> messaging "생성된 발주 메시지를 직접 전송한다"
        messaging -> supplier "발주 내용을 전달한다"
    }

    views {
        systemContext kokchack "SystemContext" {
            include *
            autoLayout lr
        }
    }
}