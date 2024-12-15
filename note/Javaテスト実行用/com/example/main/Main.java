package com.example.main;

import com.example.impl.ServiceImpl;
import com.example.interfaces.IService;

public class Main {
    // java -cp ./target com.example.main.Main
    public static void main(String[] args) {
        int num1 = 10;
        int num2 = 20;

        IService service = new ServiceImpl();
        service.execute(num1, num2);
    }
}