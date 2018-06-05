[Forma]
Clave=Cobrador
Nombre=Cobradores
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detale
PosicionInicialAltura=324
PosicionInicialAncho=701
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=161
PosicionInicialArriba=218
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaBloquearAjuste=N
PosicionColumna1=44
PosicionInicialAlturaCliente=297

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cobrador
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Cobrador.Cobrador
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.Cobrador.Cobrador]
Carpeta=Lista
Clave=Cobrador.Cobrador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detale]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cobrador
Clave=Detale
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Cobrador
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detale.Cobrador.Cobrador]
Carpeta=Detale
Clave=Cobrador.Cobrador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=39
ColorFondo=Blanco
ColorFuente=Negro

[Detale.Cobrador.Telefonos]
Carpeta=Detale
Clave=Cobrador.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detale.Cobrador.Comision]
Carpeta=Detale
Clave=Cobrador.Comision
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detale.Cobrador.Notas]
Carpeta=Detale
Clave=Cobrador.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50x8
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Cobrador=273

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
GuardarAntes=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Cobrador:Cobrador.Cobrador)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Visible=S
Activo=S
GuardarAntes=

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=Si
NombreDesplegar=E&liminar
EnBarraHerramientas=Si
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=Si
Activo=Si

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detale
Detale=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)

[Detale.ListaEnCaptura]
(Inicio)=Cobrador.Cobrador
Cobrador.Cobrador=Cobrador.Comision
Cobrador.Comision=Cobrador.Telefonos
Cobrador.Telefonos=Cobrador.Notas
Cobrador.Notas=(Fin)
