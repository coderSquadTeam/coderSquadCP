import java.util.Scanner;

public class SelectionSort {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter the number of elements: ");
        int num = sc.nextInt();

        int[] arr = new int[num];
        for (int i = 0; i < num; i++) {
            System.out.print("Element " + (i + 1) + ": ");
            arr[i] = sc.nextInt();
        }

        System.out.println("\n\nBefore the Selection Sort");
        for (int i = 0; i < num; i++) {
            System.out.print(arr[i] + " ");
        }

        int currentMin, temp, currentPos;
        for (int i = 0; i < num; i++) {
            currentMin = arr[i];
            currentPos = i;
            for (int j = i; j < num; j++) {
                if (currentMin > arr[j]) {
                    currentPos = j;
                    currentMin = arr[j];
                }
            }
            temp = arr[i];
            arr[i] = currentMin;
            arr[currentPos] = temp;
        }

        System.out.println("\n\nAfter the Selection Sort");
        for (int i = 0; i < num; i++) {
            System.out.print(arr[i] + " ");
        }
    }
}
