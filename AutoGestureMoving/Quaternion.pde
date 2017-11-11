
class AngleAxisPair{
  
     AngleAxisPair(){
       
         angle = 0;
         axis = new PVector(0, 0, 0);
     }
 
     float angle;
     PVector axis;
};

class Quaternion {

  Quaternion() {

    reset();
  }
  
  Quaternion( Quaternion other ){
   
      this.w = other.w;
      this.x = other.x;
      this.y = other.y;
      this.z = other.z;
  }

  void makeRotate(float angle, float nx, float ny, float nz) {

    angle = radians(angle);

    float epsilon = 0.0000001f;

    float length = sqrt( nx * nx + ny * ny + nz * nz );
    if (length < epsilon) {
      // ~zero length axis, so reset rotation to zero.
      reset();
      return;
    }

    float inversenorm  = 1.0f / length;
    float coshalfangle = cos( 0.5f * angle );
    float sinhalfangle = sin( 0.5f * angle );

    this.x = nx * sinhalfangle * inversenorm;
    this.y = ny * sinhalfangle * inversenorm;
    this.z = nz * sinhalfangle * inversenorm;
    this.w = coshalfangle;
    
    //println( this.x+ " " + this.y + " "  + this.z + " " + this.w);
  }

  float getRotate( PVector axis ) {

    float sinhalfangle = sqrt( (this.x * this.x) + (this.y * this.y) + (this.z * this.z) );

    float rAngle = 2.0 * atan2( sinhalfangle, this.w );

    if (sinhalfangle>0) {
      axis.x = this.x / sinhalfangle;
      axis.y = this.y / sinhalfangle;
      axis.z = this.z / sinhalfangle;
    } else {
      axis.x = 0.0;
      axis.y = 0.0;
      axis.z = 1.0;
    }
    
    return degrees(rAngle);
  }

  //----------------------------------------
  void multiply ( Quaternion other) {
    
    float nx, ny, nz, nw;
    
    nx = other.w*this.x + other.x*this.w + other.y*this.z - other.z*this.y;
    ny = other.w*this.y - other.x*this.z + other.y*this.w + other.z*this.x;
    nz = other.w*this.z + other.x*this.y - other.y*this.x + other.z*this.w;
    nw = other.w*this.w - other.x*this.x - other.y*this.y - other.z*this.z;
    
    this.x = nx;
    this.y = ny;
    this.z = nz;
    this.w = nw;
  }

  PVector rotate( PVector pt ) {
    
    //PVector v;
    //v.rotate( 35, 0.0, 0.0, 1.0);
    
    float angle = 0.0;
    PVector axis = new PVector();
    angle = getRotate( axis );

    //println( angle + " " + axis.x + " "  + axis.y + " " + axis.z);

    PVector ax = axis.normalize();
    float a = radians(angle);
    float sina = sin( a );
    float cosa = cos( a );
    float cosb = 1.0f - cosa;
    
    float nx = pt.x*(ax.x*ax.x*cosb + cosa) + pt.y*(ax.x*ax.y*cosb - ax.z*sina) + pt.z*(ax.x*ax.z*cosb + ax.y*sina);
    float ny = pt.x*(ax.y*ax.x*cosb + ax.z*sina) + pt.y*(ax.y*ax.y*cosb + cosa) + pt.z*(ax.y*ax.z*cosb - ax.x*sina);
    float nz = pt.x*(ax.z*ax.x*cosb - ax.y*sina) + pt.y*(ax.z*ax.y*cosb + ax.x*sina) + pt.z*(ax.z*ax.z*cosb + cosa);
    
    return new PVector( nx, ny, nz);
  }

  void reset() {

    x = 0;
    y = 0;
    z = 0;
    w = 1;
  }
  
  void set( Quaternion other ){
   
      this.w = other.w;
      this.x = other.x;
      this.y = other.y;
      this.z = other.z;
  }

  float x, y, z, w;
};