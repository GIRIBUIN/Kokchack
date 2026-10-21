workspace "KokChack - Container Diagram" {

    model {
        owner = person "사장" {
            description "매장을 운영하고 발주 및 장부를 관리하는 사용자"
        }

        employee = person "직원" {
            description "필요한 품목의 발주를 요청하는 사용자"
        }

        firebaseAuth = softwareSystem "Firebase Authentication" {
            description "사용자 인증을 제공하는 외부 서비스"
        }

        fcm = softwareSystem "Firebase Cloud Messaging" {
            description "Android Push Notification을 제공하는 외부 서비스"
        }

        kokchack = softwareSystem "KokChack" {
            description "소규모 자영업자를 위한 매장 발주 및 장부 관리 서비스"

            android = container "Android Application" {
                description "사장과 직원이 사용하는 모바일 애플리케이션"
                technology "Kotlin, Jetpack Compose"
            }

            web = container "PC Web Application" {
                description "사장이 사용하는 PC 관리 애플리케이션"
                technology "React, TypeScript"
            }

            api = container "Backend API" {
                description "인증, 권한 검증 및 비즈니스 로직을 처리하는 API"
                technology "TypeScript, Cloudflare Workers"
            }

            database = container "Database" {
                description "매장, 거래처, 품목, 주문, 지급 및 거래원장 데이터를 저장한다"
                technology "Cloudflare D1"
            }
        }

        owner -> android "모바일에서 서비스를 사용한다"
        employee -> android "발주를 요청한다"

        owner -> web "PC에서 매장 및 장부를 관리한다"

        android -> firebaseAuth "사용자 인증"
        web -> firebaseAuth "사용자 인증"

        android -> api "API를 호출한다" "HTTPS/JSON"
        web -> api "API를 호출한다" "HTTPS/JSON"

        api -> firebaseAuth "사용자 인증 정보를 검증한다"

        api -> database "데이터를 읽고 저장한다" "SQL"

        api -> fcm "Push Notification 전송을 요청한다"
        fcm -> android "발주 요청 알림을 전달한다"
    }

    views {
        container kokchack "Containers" {
            include *
            autoLayout lr
        }
    }
}