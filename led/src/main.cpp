#include <cstdint>

#define RCC_BASE        0x40021000
#define GPIOA_BASE      0x40010800

#define RCC_APB2ENR     (*((volatile uint32_t*)(RCC_BASE + 0x18)))
#define GPIOA_CRH       (*((volatile uint32_t*)(GPIOA_BASE + 0x04)))
#define GPIOA_ODR       (*((volatile uint32_t*)(GPIOA_BASE + 0x0C)))

#define RCC_IOPAEN      (1 << 2)

#define GPIO_MODE_OUTPUT_50MHZ   0x3
#define GPIO_CNF_GP_PUSH_PULL    0x0

void delay(int count) {
    for (int i = 0; i < count * 1000; i++) {
        asm volatile ("nop");
    }
}

int main() {
    // Enable GPIOA clock
    RCC_APB2ENR |= RCC_IOPAEN;

    // Configure PA5 as output (mode: 50 MHz, CNF: General purpose push-pull)
    GPIOA_CRH &= ~(0xF << 20);           // Clear PA5 configuration
    GPIOA_CRH |= (GPIO_MODE_OUTPUT_50MHZ << 20) | (GPIO_CNF_GP_PUSH_PULL << 22);

    // Main loop
    while (1) {
        // Toggle PA5 (LED)
        GPIOA_ODR ^= (1 << 5);

        // Simple delay
        delay(500);
    }

    return 0;
}
