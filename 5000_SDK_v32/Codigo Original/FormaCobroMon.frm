
[Forma]
Clave=FormaCobroMon
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Forma Cobro Monedero

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
PosicionInicialIzquierda=2582
PosicionInicialArriba=350
PosicionInicialAlturaCliente=136
PosicionInicialAncho=591
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaCobroMon
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Hoja.FormaCobroMon.FormaCobro]
Carpeta=Hoja
Clave=FormaCobroMon.FormaCobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.FormaCobroMon.Objeto]
Carpeta=Hoja
Clave=FormaCobroMon.Objeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.Columnas]
FormaCobro=212
Objeto=173

ObjetoPOS=152
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



[Hoja.ListaEnCaptura]
(Inicio)=FormaCobroMon.FormaCobro
FormaCobroMon.FormaCobro=FormaCobroMon.Objeto
FormaCobroMon.Objeto=FormaCobroMon.ObjetoPOS
FormaCobroMon.ObjetoPOS=(Fin)

[Hoja.FormaCobroMon.ObjetoPOS]
Carpeta=Hoja
Clave=FormaCobroMon.ObjetoPOS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
