import java.util.Scanner;

public class BubbleSort {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter the number of elements: ");
        int num = sc.nextInt();

        int[] arr = new int[num];
        for (int i = 0; i < num; i++) {
            System.out.print("Element " + (i + 1) + ": ");
            arr[i] = sc.nextInt();
        }

        System.out.println("\n\nBefore the Bubble Sort");
        for (int i = 0; i < num; i++) {
            System.out.print(arr[i] + " ");
        }

        int temp;
        for (int i = 0; i < num; i++) {
            for (int j = i + 1; j < num; j++) {
                if (arr[i] > arr[j]) {
                    temp = arr[j];
                    arr[j] = arr[i];
                    arr[i] = temp;
                }
            }
        }

        System.out.println("\n\nAfter the Bubble Sort");
        for (int i = 0; i < num; i++) {
            System.out.print(arr[i] + " ");
        }
    }

}
