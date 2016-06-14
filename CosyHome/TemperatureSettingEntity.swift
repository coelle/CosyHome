import Foundation


struct TemperatureSettingEntity {
    
    static private let MaxTemperature = 30.0
    static private let MinTemperature = 7.0
    
    var previous: Double?
    var next: Double?
    var _temperature: Double
    
    
    var temperature: Double {
        
        get {
        
            var temperature = _temperature
            
            if let minimumTemperature = previous where temperature <= minimumTemperature {
                temperature = minimumTemperature + 1
            }
            
            if let maximumTemperature = next where temperature >= maximumTemperature {
                temperature = maximumTemperature - 1
            }
            
            return max(TemperatureSettingEntity.MinTemperature, min(temperature, TemperatureSettingEntity.MaxTemperature))
            
        }
        
    }
    
    var maximum: Double {
        
        get {
            
            guard let next = next else {
                return TemperatureSettingEntity.MaxTemperature
            }
            
            return next - 1.0
        }
        
    }
    
    var minimum: Double {
        
        get {
            guard let previous = previous else {
                return TemperatureSettingEntity.MinTemperature
            }
            
            return previous + 1.0
        }
    }
    
    init(temperature: Double = 0.0,  previous: Double? = nil, next: Double? = nil) {
        self.previous = previous
        self.next = next
        self._temperature = temperature
    }
    
    
    mutating func adjustTemperature(temperature: Double) {
        self._temperature = temperature
    }
    
    //MARK: Factory Method
    
    static func entitiesWithTemperaturesLow(low: Double, middle: Double, high: Double ) -> (low: TemperatureSettingEntity, middle: TemperatureSettingEntity, high: TemperatureSettingEntity) {
        
        let slumberSetting = TemperatureSettingEntity(temperature: low,  next: middle )
        let comfySetting = TemperatureSettingEntity(previous: low, temperature: middle, next: high)
        let cosySetting = TemperatureSettingEntity(previous: middle, temperature: high)
        
        return (slumberSetting, comfySetting, cosySetting)
        
        
    }
}
