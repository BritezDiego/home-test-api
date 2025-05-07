package com.home.test;

import com.intuit.karate.junit5.Karate;

class InventoryTestRunner {

    @Karate.Test
    Karate runAllTests() {
        return Karate.run("classpath:features/inventory_test.feature");
    }
}
