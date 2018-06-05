[Forma]
Clave=CFDFolio
Nombre=Folios - Comprobante Fiscal Digital
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=189
PosicionInicialArriba=295
PosicionInicialAlturaCliente=407
PosicionInicialAncho=901
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.ConsecutivoModulo, Info.Mov)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDFolio
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=CFDFolio.Modulo=<T>{Info.ConsecutivoModulo}<T> AND CFDFolio.Mov=<T>{Info.Mov}<T>

[Lista.CFDFolio.Empresa]
Carpeta=Lista
Clave=CFDFolio.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CFDFolio.Sucursal]
Carpeta=Lista
Clave=CFDFolio.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CFDFolio.Serie]
Carpeta=Lista
Clave=CFDFolio.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CFDFolio.FolioD]
Carpeta=Lista
Clave=CFDFolio.FolioD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CFDFolio.FolioA]
Carpeta=Lista
Clave=CFDFolio.FolioA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CFDFolio.Folio]
Carpeta=Lista
Clave=CFDFolio.Folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CFDFolio.noAprobacion]
Carpeta=Lista
Clave=CFDFolio.noAprobacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CFDFolio.fechaAprobacion]
Carpeta=Lista
Clave=CFDFolio.fechaAprobacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CFDFolio.Estatus]
Carpeta=Lista
Clave=CFDFolio.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Empresa=48
Sucursal=47
Serie=35
FolioD=64
FolioA=64
Folio=59
noAprobacion=98
fechaAprobacion=94
Estatus=64
Nombre=110
Nombre_1=120
Nivel=59

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.CFDFolio.Nivel]
Carpeta=Lista
Clave=CFDFolio.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CFDFolio.Empresa
CFDFolio.Empresa=Empresa.Nombre
Empresa.Nombre=CFDFolio.Nivel
CFDFolio.Nivel=CFDFolio.Sucursal
CFDFolio.Sucursal=Sucursal.Nombre
Sucursal.Nombre=CFDFolio.Serie
CFDFolio.Serie=CFDFolio.FolioD
CFDFolio.FolioD=CFDFolio.FolioA
CFDFolio.FolioA=CFDFolio.Folio
CFDFolio.Folio=CFDFolio.noAprobacion
CFDFolio.noAprobacion=CFDFolio.fechaAprobacion
CFDFolio.fechaAprobacion=CFDFolio.Estatus
CFDFolio.Estatus=(Fin)

[Lista.ListaOrden]
(Inicio)=CFDFolio.Empresa<TAB>(Acendente)
CFDFolio.Empresa<TAB>(Acendente)=CFDFolio.Sucursal<TAB>(Acendente)
CFDFolio.Sucursal<TAB>(Acendente)=CFDFolio.Serie<TAB>(Acendente)
CFDFolio.Serie<TAB>(Acendente)=CFDFolio.FolioD<TAB>(Acendente)
CFDFolio.FolioD<TAB>(Acendente)=CFDFolio.FolioA<TAB>(Acendente)
CFDFolio.FolioA<TAB>(Acendente)=(Fin)
