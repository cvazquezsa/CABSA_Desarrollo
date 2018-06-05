[Forma]
Clave=EmbarqueTarifa
Nombre=Tarifas Embarque
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=372
PosicionInicialArriba=336
PosicionInicialAltura=345
PosicionInicialAncho=535
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=318

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueTarifa
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
PermiteEditar=S
ListaEnCaptura=(Lista)
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Costos

[Lista.EmbarqueTarifa.Agrupador]
Carpeta=Lista
Clave=EmbarqueTarifa.Agrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueTarifa.Nombre]
Carpeta=Lista
Clave=EmbarqueTarifa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Agrupador=113
Nombre=159
CostoVenta=99
CostoInv=123
CostoCompra=109
Moneda=56
PorcentajeVenta=74
PorcentajeInv=73
PorcentajeCompra=64

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

[Lista.EmbarqueTarifa.PorcentajeVenta]
Carpeta=Lista
Clave=EmbarqueTarifa.PorcentajeVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueTarifa.PorcentajeInv]
Carpeta=Lista
Clave=EmbarqueTarifa.PorcentajeInv
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueTarifa.PorcentajeCompra]
Carpeta=Lista
Clave=EmbarqueTarifa.PorcentajeCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=EmbarqueTarifa.Agrupador
EmbarqueTarifa.Agrupador=EmbarqueTarifa.Nombre
EmbarqueTarifa.Nombre=EmbarqueTarifa.PorcentajeVenta
EmbarqueTarifa.PorcentajeVenta=EmbarqueTarifa.PorcentajeInv
EmbarqueTarifa.PorcentajeInv=EmbarqueTarifa.PorcentajeCompra
EmbarqueTarifa.PorcentajeCompra=(Fin)
