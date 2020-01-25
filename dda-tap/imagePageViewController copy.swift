//
//  TutorialPageViewcONTROLLERViewController.swift
//  swip left and right
//
//  Created by Fengpeng Huang on 2019-11-02.
//  Copyright © 2019 Patrick. All rights reserved.
//

import UIKit


class mainViewController: UIViewController{

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var containerView: UIView!
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
            if let mainPageViewController = segue.destination as? mainPageViewController{
            mainPageViewController.mainDelegate = self
        }
    }
}
    
extension mainViewController: mainPageViewControllerDelegate{
    func mainPageViewController(mainPageViewController: mainPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func mainPageViewController(mainPageViewController: mainPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}











class mainPageViewController: UIPageViewController {
    
    weak var mainDelegate: mainPageViewControllerDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController]={
        return [self.newViewController(order: "First"),
                self.newViewController(order: "Second"),
                self.newViewController(order: "Third")]
    }()

    private func newViewController(order:String)->UIViewController{
        return UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "\(order)ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        mainDelegate?.mainPageViewController(mainPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



extension mainPageViewController:UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers:[UIViewController],
                            transitionCompleted completed:Bool){
        if let firstViewController=viewControllers?.first,
            let index=orderedViewControllers.index(of: firstViewController){
            mainDelegate?.mainPageViewController(mainPageViewController: self,
                                                         didUpdatePageIndex: index)
        }
    }
}


protocol mainPageViewControllerDelegate:class {
    func mainPageViewController(mainPageViewController: mainPageViewController,didUpdatePageCount count: Int)
    func mainPageViewController(mainPageViewController: mainPageViewController,didUpdatePageIndex index: Int)
}


extension mainPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let ViewControllerIndex=orderedViewControllers.index(of: viewController) else{
            return nil
        }
        
        let previousIndex = ViewControllerIndex-1
        
        guard previousIndex >= 0 else{
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else{
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let ViewControllerIndex=orderedViewControllers.index(of: viewController) else{
            return nil
        }
        
        let nextIndex = ViewControllerIndex+1
        let orderedViewControllersCount=orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else{
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else{
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    /*
    func presentationCountForPageViewController(pageViewController: UIPageViewController)->Int{
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController)->Int{
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else{
                return 0
        }
        return firstViewControllerIndex
        
    }
 */
}
