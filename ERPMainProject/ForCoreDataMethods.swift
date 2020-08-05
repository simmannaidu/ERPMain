//
//  ForCoreDataMethods.swift
//  AyersERP
//
//  Created by Hari on 28/11/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import CoreData
extension UIViewController
{
    func toAddItemInCoredata(product_id : String , available_quantity : String , product_quantity : String ,product_rate : String , discount : String , total_price : String , tax : String , discount_amount : String , image : String ,product_name : String , unit : String)
    {
       // let person =
          //  NSEntityDescription.entity(forEntityName: "Cart",
                  //                     in: context)!
        //sub_category_id
        //category_id
        //productImage
        //productName
        //let person = NSManagedObject(entity: entity,
                                   //  insertInto: context)
        let entity = NSEntityDescription.entity(forEntityName: "Cart1", in: context)
        let person = NSManagedObject(entity: entity!, insertInto: context)
        
        
        person.setValue(product_id, forKeyPath: "product_id")
        person.setValue(available_quantity, forKeyPath: "available_quantity")
        person.setValue(product_quantity, forKeyPath: "product_quantity")
        person.setValue(product_rate, forKeyPath: "product_rate")
        person.setValue(discount, forKeyPath: "discount")
        person.setValue(total_price, forKeyPath: "total_price")
        person.setValue(tax, forKeyPath: "tax")
        person.setValue(discount_amount, forKeyPath: "discount_amount")
        person.setValue(image, forKeyPath: "image")
        person.setValue(product_name, forKeyPath: "product_name")
        person.setValue(unit, forKeyPath: "unit")
       
        do {
            try context.save()
           // let array1 = getDataFromCoreData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func updateItemInCoreData(product_id : String , available_quantity : String , product_quantity : String ,product_rate : String , discount : String , total_price : String , tax : String ,discount_amount : String , positionValue : NSInteger , image : String ,product_name : String,unit : String)
        
    {
        /*let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
         //request.predicate = NSPredicate(format: "age = %@", "12")
         request.returnsObjectsAsFaults = false
         do {
         let result = try context.fetch(request)
         for data in result as! [NSManagedObject] {
         print(data.value(forKey: "username") as! String)
         }
         
         } catch {
         
         print("Failed")
         }*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart1")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let object : NSManagedObject = result[positionValue] as! NSManagedObject
            object.setValue(product_id , forKey: "product_id")
            object.setValue(available_quantity , forKey: "available_quantity")
            object.setValue(product_quantity , forKey: "product_quantity")
            object.setValue(product_rate , forKey: "product_rate")
            object.setValue(discount , forKey: "discount")
            object.setValue(total_price , forKey: "total_price")
            object.setValue(tax , forKey: "tax")
            object.setValue(discount_amount , forKey: "discount_amount")
            object.setValue(image , forKey: "image")
            object.setValue(product_name , forKey: "product_name")
            object.setValue(unit, forKey: "unit")
            appDelegate.saveContext()
        }
        catch
        {
        }
        // NSArray*Array=[context executeFetchRequest:fetchRequest error:nil];
        //NSManagedObject* object = [Array objectAtIndex:postion];
    }
    func delectAllElements()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart1")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for item in result
            {
               // let object : NSManagedObject = result[position] as! NSManagedObject
                context.delete(item as! NSManagedObject)
            }
            
        }
        catch
        {
            
        }
    }
    func delectItemFromCart( position : NSInteger)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart1")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let object : NSManagedObject = result[position] as! NSManagedObject
            context.delete(object)
        }
        catch
        {
            
        }
        
    }
    
    func getDataFromCoreData() -> [NSDictionary]
    {
        var dataInCart = [NSDictionary]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart1")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let dataDic = NSMutableDictionary()
                dataDic.setValue((data.primitiveValue(forKey: "product_id") ?? ""), forKey: "product_id")
                dataDic.setValue((data.primitiveValue(forKey: "available_quantity") ?? ""), forKey: "available_quantity")
                dataDic.setValue((data.primitiveValue(forKey: "product_quantity") ?? ""), forKey: "product_quantity")
                dataDic.setValue((data.primitiveValue(forKey: "product_rate") ?? ""), forKey: "product_rate")
                dataDic.setValue((data.primitiveValue(forKey: "discount") ?? ""), forKey: "discount")
                dataDic.setValue((data.primitiveValue(forKey: "total_price") ?? ""), forKey: "total_price")
                dataDic.setValue((data.primitiveValue(forKey: "tax") ?? ""), forKey: "tax")
                dataDic.setValue((data.primitiveValue(forKey: "discount_amount") ?? ""), forKey: "discount_amount")
               dataDic.setValue((data.primitiveValue(forKey: "image") ?? ""), forKey: "image")
               dataDic.setValue((data.primitiveValue(forKey: "product_name") ?? ""), forKey: "product_name")
                dataDic.setValue((data.primitiveValue(forKey: "unit") ?? ""), forKey: "unit")
                dataInCart.append(dataDic)
                
            }
            print("==============\(dataInCart.count)============")
        } catch {
            print(error)
            print("Failed")
        }
        return dataInCart
    }
}
