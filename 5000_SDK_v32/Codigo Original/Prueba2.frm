[Forma]
Clave=Prueba2
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=437
PosicionInicialArriba=212
PosicionInicialAlturaCliente=628
PosicionInicialAncho=601
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Ficha]
Estilo=Ficha
Pestana=S
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Prueba2
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

[Ficha.prueba2.id]
Carpeta=Ficha
Clave=prueba2.id
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.prueba2.imagen]
Carpeta=Ficha
Clave=prueba2.imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=500x500
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Refrescar Controles]
Nombre=Refrescar Controles
Boton=1
NombreDesplegar=Refrescar Controles
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Refrescar Controles
Refrescar Controles=Guardar Cambios
Guardar Cambios=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=prueba2.id
prueba2.id=prueba2.imagen
prueba2.imagen=(Fin)
