[Forma]
Clave=LoteFijo
Nombre=Lotes Fijos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=342
PosicionInicialArriba=288
PosicionInicialAlturaCliente=420
PosicionInicialAncho=596
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LoteFijo
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Lista.LoteFijo.Lote]
Carpeta=Lista
Clave=LoteFijo.Lote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LoteFijo.Impuesto1]
Carpeta=Lista
Clave=LoteFijo.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LoteFijo.Impuesto2]
Carpeta=Lista
Clave=LoteFijo.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Lote=205
Impuesto1=53
Impuesto2=57
Impuesto3=76
Cuenta1=124
Cuenta2=124

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

[Lista.LoteFijo.Cuenta1]
Carpeta=Lista
Clave=LoteFijo.Cuenta1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LoteFijo.Cuenta2]
Carpeta=Lista
Clave=LoteFijo.Cuenta2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=LoteFijo.Lote
LoteFijo.Lote=LoteFijo.Impuesto1
LoteFijo.Impuesto1=LoteFijo.Cuenta1
LoteFijo.Cuenta1=LoteFijo.Impuesto2
LoteFijo.Impuesto2=LoteFijo.Cuenta2
LoteFijo.Cuenta2=(Fin)
