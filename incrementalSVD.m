%% A code for TSVD
function [Up,Sp,Vp] = incrementalSVD( U, S, V, A, force_orth )
  current_rank = size( U, 2 );
  m = U' * A;
  p = A - U*m;
  P = orth( p );
  P = [ P zeros(size(P,1), size(p,2)-size(P,2)) ];

  Ra = P' * p;
  z = zeros( size(m) );
  K = [ S m ; z' Ra ];
  [tUp,tSp,tVp] = svd( K);

  Sp = tSp;
  Up = [ U P ] * tUp;
  
  if ( ~isempty(V) )
    Vp = V * tVp( 1:current_rank, : );
  else
    Vp = [];
  end
  Vp = [ Vp ; tVp( current_rank+1:size(tVp,1), : ) ];

  if ( force_orth )
    [UQ,UR] = qr( Up, 0 );
    [VQ,VR] = qr( Vp, 0 );
    [tUp,tSp,tVp] = svds( UR * Sp * VR', current_rank );
    Up = UQ * tUp;
    Vp = VQ * tVp;
    Sp = tSp;
  end
  
end