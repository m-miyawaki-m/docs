package com.example.impl;

import java.util.Optional;

import com.example.interfaces.IService;

public class ServiceImpl implements IService {
    @Override
    public void execute(int num1, int num2) {
        int result = num1 + num2;
        Optional.ofNullable(result).ifPresent(System.out::println);
    }
}
