[Forma]
Clave=OtrosCargos
Nombre=Otros Cargos (Automáticos)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=154
PosicionInicialArriba=209
PosicionInicialAlturaCliente=315
PosicionInicialAncho=716
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
Vista=OtrosCargos
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
CarpetaVisible=S

[Lista.OtrosCargos.OtrosCargos]
Carpeta=Lista
Clave=OtrosCargos.OtrosCargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OtrosCargos.Articulo]
Carpeta=Lista
Clave=OtrosCargos.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OtrosCargos.Tipo]
Carpeta=Lista
Clave=OtrosCargos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OtrosCargos.Porcentaje]
Carpeta=Lista
Clave=OtrosCargos.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OtrosCargos.Importe]
Carpeta=Lista
Clave=OtrosCargos.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OtrosCargos.Moneda]
Carpeta=Lista
Clave=OtrosCargos.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
OtrosCargos=269
Articulo=102
Tipo=110
Porcentaje=39
Importe=90
Moneda=71

[Lista.ListaEnCaptura]
(Inicio)=OtrosCargos.OtrosCargos
OtrosCargos.OtrosCargos=OtrosCargos.Articulo
OtrosCargos.Articulo=OtrosCargos.Tipo
OtrosCargos.Tipo=OtrosCargos.Porcentaje
OtrosCargos.Porcentaje=OtrosCargos.Importe
OtrosCargos.Importe=OtrosCargos.Moneda
OtrosCargos.Moneda=(Fin)
