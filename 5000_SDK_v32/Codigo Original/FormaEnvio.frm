[Forma]
Clave=FormaEnvio
Nombre=Formas de Envío
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=198
PosicionInicialArriba=202
PosicionInicialAltura=368
PosicionInicialAncho=649
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=37
PosicionInicialAlturaCliente=361

PosicionCol1=235
[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaEnvio
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=FormaEnvio.FormaEnvio
CarpetaVisible=S
HojaMantenerSeleccion=S
PestanaOtroNombre=S

[Lista.FormaEnvio.FormaEnvio]
Carpeta=Lista
Clave=FormaEnvio.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
FormaEnvio=201

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Forma Envío
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=FormaEnvio
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=4
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

[Detalle.FormaEnvio.FormaEnvio]
Carpeta=Detalle
Clave=FormaEnvio.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.FormaEnvio.Direccion]
Carpeta=Detalle
Clave=FormaEnvio.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
EspacioPrevio=N

[Detalle.FormaEnvio.Colonia]
Carpeta=Detalle
Clave=FormaEnvio.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.FormaEnvio.CodigoPostal]
Carpeta=Detalle
Clave=FormaEnvio.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.FormaEnvio.Poblacion]
Carpeta=Detalle
Clave=FormaEnvio.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.FormaEnvio.Estado]
Carpeta=Detalle
Clave=FormaEnvio.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.FormaEnvio.Pais]
Carpeta=Detalle
Clave=FormaEnvio.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.FormaEnvio.Encargado]
Carpeta=Detalle
Clave=FormaEnvio.Encargado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco

[Detalle.FormaEnvio.Telefonos]
Carpeta=Detalle
Clave=FormaEnvio.Telefonos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(FormaEnvio:FormaEnvio.FormaEnvio)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
GuardarAntes=
GuardarConfirmar=
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Visible=S
Activo=S
EspacioPrevio=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=Si
NombreDesplegar=E&liminar
EnBarraHerramientas=Si
ConfirmarAntes=Si
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=Si
Activo=Si

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=Si
EspacioPrevio=Si
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Visible=Si
Activo=Si

[Detalle.FormaEnvio.Embarcar]
Carpeta=Detalle
Clave=FormaEnvio.Embarcar
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco



[Detalle.ListaEnCaptura]
(Inicio)=FormaEnvio.FormaEnvio
FormaEnvio.FormaEnvio=FormaEnvio.Direccion
FormaEnvio.Direccion=FormaEnvio.Colonia
FormaEnvio.Colonia=FormaEnvio.CodigoPostal
FormaEnvio.CodigoPostal=FormaEnvio.Poblacion
FormaEnvio.Poblacion=FormaEnvio.Estado
FormaEnvio.Estado=FormaEnvio.Pais
FormaEnvio.Pais=FormaEnvio.Telefonos
FormaEnvio.Telefonos=FormaEnvio.Encargado
FormaEnvio.Encargado=FormaEnvio.Embarcar
FormaEnvio.Embarcar=FormaEnvio.EsPropia
FormaEnvio.EsPropia=(Fin)

[Detalle.FormaEnvio.EsPropia]
Carpeta=Detalle
Clave=FormaEnvio.EsPropia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)
