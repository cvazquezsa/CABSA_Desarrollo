[Forma]
Clave=AnexoCtaCfg
Nombre=e(<T>Editar Anexos<T>)+<T> - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=444
PosicionInicialArriba=35
PosicionInicialAltura=402
PosicionInicialAncho=648
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
PosicionInicialAlturaCliente=592

[Lista]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoCta
Fuente={MS Sans Serif, 8, Negro, []}
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
ListaOrden=AnexoCta.Orden<TAB>(Acendente)
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=Rama=<T>{Info.Rama}<T> AND Cuenta=<T>{Info.Cuenta}<T>
[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoCta
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

[Lista.Columnas]
Nombre=269
Direccion=321
Tipo=106

Documento=204
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
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S

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

[Imagen.Anexo.Imagen]
Carpeta=Imagen
Clave=Anexo.Imagen
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comentario.Anexo.Comentario]
Carpeta=Comentario
Clave=Anexo.Comentario
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.URL]
Nombre=URL
Boton=57
NombreEnBoton=S
NombreDesplegar=&Examinar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=URL(AnexoCta:AnexoCta.Direccion)
ActivoCondicion=AnexoCta:AnexoCta.Tipo<><T>Comentario<T>

[Lista.AnexoCta.Nombre]
Carpeta=Lista
Clave=AnexoCta.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.AnexoCta.Tipo]
Carpeta=Lista
Clave=AnexoCta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.AnexoCta.Tipo]
Carpeta=Detalle
Clave=AnexoCta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.AnexoCta.Nombre]
Carpeta=Detalle
Clave=AnexoCta.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=37
ColorFondo=Blanco

[Detalle.AnexoCta.Icono]
Carpeta=Detalle
Clave=AnexoCta.Icono
Editar=S
ValidaNombre=S
3D=S
Pegado=N
ColorFondo=Blanco

[Detalle.AnexoCta.Direccion]
Carpeta=Detalle
Clave=AnexoCta.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=62
ColorFondo=Blanco

[Detalle.AnexoCta.Comentario]
Carpeta=Detalle
Clave=AnexoCta.Comentario
Editar=S
LineaNueva=S
3D=S
Tamano=62x12
ColorFondo=Blanco

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>AnexoCtaOrdenar<T>)

[Mensaje]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mensaje
Clave=Mensaje
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoCta
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
CondicionVisible=AnexoCta:AnexoCta.Tipo=<T>Mensaje<T>

[Mensaje.AnexoCta.Fecha]
Carpeta=Mensaje
Clave=AnexoCta.Fecha
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje.AnexoCta.Origen]
Carpeta=Mensaje
Clave=AnexoCta.Origen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje.AnexoCta.Destino]
Carpeta=Mensaje
Clave=AnexoCta.Destino
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55x10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta.FechaEmision]
Carpeta=Detalle
Clave=AnexoCta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Detalle.AnexoCta.Vencimiento]
Carpeta=Detalle
Clave=AnexoCta.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Contrato
Clave=Contrato
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoCta
Fuente={Tahoma, 8, Negro, []}
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
CondicionVisible=AnexoCta:AnexoCta.Tipo=<T>Contrato<T>

[Contrato.AnexoCta.TipoDocumento]
Carpeta=Contrato
Clave=AnexoCta.TipoDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta.FechaEmision]
Carpeta=Contrato
Clave=AnexoCta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta.Inicio]
Carpeta=Contrato
Clave=AnexoCta.Inicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta.Vencimiento]
Carpeta=Contrato
Clave=AnexoCta.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta.Categoria]
Carpeta=Contrato
Clave=AnexoCta.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta.Grupo]
Carpeta=Contrato
Clave=AnexoCta.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta.Familia]
Carpeta=Contrato
Clave=AnexoCta.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta.NivelAcceso]
Carpeta=Detalle
Clave=AnexoCta.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Mensaje.ListaEnCaptura]
(Inicio)=AnexoCta.Fecha
AnexoCta.Fecha=AnexoCta.Origen
AnexoCta.Origen=AnexoCta.Destino
AnexoCta.Destino=(Fin)

[Contrato.ListaEnCaptura]
(Inicio)=AnexoCta.TipoDocumento
AnexoCta.TipoDocumento=AnexoCta.FechaEmision
AnexoCta.FechaEmision=AnexoCta.Inicio
AnexoCta.Inicio=AnexoCta.Vencimiento
AnexoCta.Vencimiento=AnexoCta.Categoria
AnexoCta.Categoria=AnexoCta.Grupo
AnexoCta.Grupo=AnexoCta.Familia
AnexoCta.Familia=(Fin)


[Detalle.AnexoCta.Direccion2]
Carpeta=Detalle
Clave=AnexoCta.Direccion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
















[Detalle.AnexoCta.Direccion3]
Carpeta=Detalle
Clave=AnexoCta.Direccion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco














[Acciones.Archivo]
Nombre=Archivo
Boton=77
NombreDesplegar=&Cargar Archivo
EnBarraHerramientas=S
TipoAccion=Expresion



NombreEnBoton=S


EspacioPrevio=S






















































Expresion=Caso  AnexoCta:AnexoCta.Tipo<BR>  Es <T>Imagen<T> Entonces FormaModal(<T>AnexoCtaCargarArchivo<T>)<BR>Sino<BR>  FormaModal(<T>AnexoCargarArchivo<T>) <BR>Fin<BR>Asigna(AnexoCta:AnexoCta.Direccion,Info.Directorio)<BR>Asigna(AnexoCta:AnexoCta.Direccion2,Info.Clase2)<BR>Asigna(AnexoCta:AnexoCta.Direccion3,Info.Clase3)
ActivoCondicion=AnexoCta:AnexoCta.Tipo en (<T>Archivo<T>, <T>Imagen<T>,<T>Contrato<T>)
VisibleCondicion=General.AnexosCloud











[Detalle.AnexoCta.Documento]
Carpeta=Detalle
Clave=AnexoCta.Documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Detalle.ListaEnCaptura]
(Inicio)=AnexoCta.Tipo
AnexoCta.Tipo=AnexoCta.Nombre
AnexoCta.Nombre=AnexoCta.Icono
AnexoCta.Icono=AnexoCta.Documento
AnexoCta.Documento=AnexoCta.Direccion
AnexoCta.Direccion=AnexoCta.Direccion2
AnexoCta.Direccion2=AnexoCta.Direccion3
AnexoCta.Direccion3=AnexoCta.Comentario
AnexoCta.Comentario=AnexoCta.FechaEmision
AnexoCta.FechaEmision=AnexoCta.Vencimiento
AnexoCta.Vencimiento=AnexoCta.NivelAcceso
AnexoCta.NivelAcceso=(Fin)



[Lista.ListaEnCaptura]
(Inicio)=AnexoCta.Nombre
AnexoCta.Nombre=AnexoCta.Tipo
AnexoCta.Tipo=AnexoCta.Documento
AnexoCta.Documento=(Fin)

[Lista.AnexoCta.Documento]
Carpeta=Lista
Clave=AnexoCta.Documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Mensaje
Mensaje=Contrato
Contrato=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=URL
URL=Ordenar
Ordenar=Archivo
Archivo=Navegador
Navegador=(Fin)
