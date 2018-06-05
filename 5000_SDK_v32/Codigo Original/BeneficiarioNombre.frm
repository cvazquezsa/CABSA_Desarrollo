[Forma]
Clave=BeneficiarioNombre
Nombre=Beneficiarios
Icono=0
Modulos=DIN
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalles
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=253
PosicionInicialArriba=196
PosicionInicialAltura=250
PosicionInicialAncho=518
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionColumna1=37
PosicionInicialAlturaCliente=342

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=BeneficiarioNombre
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=BeneficiarioNombre.Beneficiario
CarpetaVisible=S
HojaConfirmarEliminar=S
HojaMantenerSeleccion=S

[Lista.BeneficiarioNombre.Beneficiario]
Carpeta=Lista
Clave=BeneficiarioNombre.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Beneficiario=157
ImporteOmision=100
ConceptoOmision=173

[Detalle.BeneficiarioNombre.Beneficiario]
Carpeta=Detalle
Clave=BeneficiarioNombre.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.BeneficiarioNombre.ImporteOmision]
Carpeta=Detalle
Clave=BeneficiarioNombre.ImporteOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N

[Detalle.BeneficiarioNombre.ConceptoOmision]
Carpeta=Detalle
Clave=BeneficiarioNombre.ConceptoOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Beneficiario
Clave=Detalles
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=BeneficiarioNombre
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

[Detalles.BeneficiarioNombre.Beneficiario]
Carpeta=Detalles
Clave=BeneficiarioNombre.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.BeneficiarioNombre.ImporteOmision]
Carpeta=Detalles
Clave=BeneficiarioNombre.ImporteOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(BeneficiarioNombre:BeneficiarioNombre.Beneficiario)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

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
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalles
Detalles=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)

[Detalles.ListaEnCaptura]
(Inicio)=BeneficiarioNombre.Beneficiario
BeneficiarioNombre.Beneficiario=BeneficiarioNombre.ImporteOmision
BeneficiarioNombre.ImporteOmision=(Fin)
