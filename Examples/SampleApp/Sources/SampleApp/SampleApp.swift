import SwiftUI
import FirebaseAnalytics
import FirebaseCrashlytics

// FirebaseCore genellikle diğer modüllerle birlikte gelir, ancak
// eğer doğrudan erişilemiyorsa wrapper'ların import edilmesi yeterli olabilir.
// Bu örnekte basitçe Analytics ve Crashlytics'i import ediyoruz.

@main
struct SampleApp: App {
    init() {
        // FirebaseApp.configure() çağrısı normalde gereklidir.
        // Ancak InternalFirebase yapısında bu wrapper'lar içinde otomatik yapılıyor olabilir
        // veya FirebaseCore'a erişimimiz olmayabilir.
        // Standart Firebase kullanımında:
        // import FirebaseCore
        // FirebaseApp.configure()
        
        // Eğer derleme hatası alırsanız, InternalFirebase'in FirebaseCore'u export etmesi gerekebilir.
        print("SampleApp Initialized")
    }

    var body: some Scene {
        WindowGroup {
            VStack {
                Image(systemName: "flame.fill")
                    .imageScale(.large)
                    .foregroundStyle(.red)
                Text("InternalFirebase Sample")
                    .font(.title)
                
                Button("Log Event") {
                    Analytics.logEvent("sample_button_click", parameters: nil)
                    print("Event logged")
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
