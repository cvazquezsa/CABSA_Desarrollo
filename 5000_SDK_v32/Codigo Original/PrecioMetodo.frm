[Forma]
Clave=PrecioMetodo
Nombre=Métodos (Precios y Costos)
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=697
PosicionInicialArriba=437
PosicionInicialAlturaCliente=298
PosicionInicialAncho=566
PosicionCol1=239
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PrecioMetodo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=PrecioMetodo.Metodo
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.PrecioMetodo.Metodo]
Carpeta=Lista
Clave=PrecioMetodo.Metodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=PrecioMetodo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.PrecioMetodo.Metodo]
Carpeta=Ficha
Clave=PrecioMetodo.Metodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PrecioMetodo.Base]
Carpeta=Ficha
Clave=PrecioMetodo.Base
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PrecioMetodo.Usar]
Carpeta=Ficha
Clave=PrecioMetodo.Usar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PrecioMetodo.Redondear]
Carpeta=Ficha
Clave=PrecioMetodo.Redondear
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=16
EspacioPrevio=S

[Ficha.PrecioMetodo.Redondeo]
Carpeta=Ficha
Clave=PrecioMetodo.Redondeo
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
Pegado=S

[Lista.Columnas]
Metodo=206

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Ficha.PrecioMetodo.Monto]
Carpeta=Ficha
Clave=PrecioMetodo.Monto
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
ValidaNombre=S

[Ficha.PrecioMetodo.MontoFijo]
Carpeta=Ficha
Clave=PrecioMetodo.MontoFijo
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=PrecioMetodo.Metodo
PrecioMetodo.Metodo=PrecioMetodo.Base
PrecioMetodo.Base=PrecioMetodo.Usar
PrecioMetodo.Usar=PrecioMetodo.Monto
PrecioMetodo.Monto=PrecioMetodo.MontoFijo
PrecioMetodo.MontoFijo=PrecioMetodo.Redondear
PrecioMetodo.Redondear=PrecioMetodo.Redondeo
PrecioMetodo.Redondeo=(Fin)
